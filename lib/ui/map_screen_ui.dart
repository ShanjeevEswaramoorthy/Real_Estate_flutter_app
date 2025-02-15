import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:real_estate_app/utils/constant.dart';

import '../utils/widget_function.dart';

class MapScreenUI extends StatefulWidget {
  final double lat;
  final double long;
  final String idAsName;
  final String image;
  const MapScreenUI(
      {super.key,
      required this.lat,
      required this.long,
      required this.idAsName,
      required this.image});

  @override
  State<MapScreenUI> createState() => _MapScreenUIState();
}

class _MapScreenUIState extends State<MapScreenUI> {
  /// Initializes an instance of the [Location] class from the location package in Flutter.
  Location locationController = Location();

  LatLng? currentLocation;
  LatLng? userLiveLocation;

  /// custom marker
  BitmapDescriptor? customMarker;

  /// instance og the [Completer<GoogleMapController>()] from the google map package
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  /// it will used the store a polyline route with an PolylineId
  Map<PolylineId, Polyline> polyLines = {};

  @override
  void initState() {
    super.initState();

    /// [getLocation] call the method while building the widget and check for the location permission
    getLocation().then((_) =>

        /// [generatePolylineCoordinates] it will return [<List<LatLng>>] to draw the route
        generatePolylineCoordinates().then(
          (value) =>

              /// [generatePloylineRoute] it will generate the polyline route
              /// with input of [<List<LatLng>>] from [generatePolylineCoordinates]
              generatePloylineRoute(value),
        ));

    loadCustomMarker();
  }

  /// Load the custom marker from assets
  Future<void> loadCustomMarker() async {
    final Uint8List markerIcon =
        // await getBytesFromAssetForAnimation(widget.image, 100);
        await getBytesFromNetworkImage(widget.image, 100);

    setState(() {
      customMarker = BitmapDescriptor.bytes(markerIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (currentLocation == null || userLiveLocation == null)
          ? const Center(
              child: Text('LOading'),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long), zoom: 13),
              markers: {
                Marker(
                    markerId: const MarkerId('UserLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: currentLocation!),
                Marker(
                    markerId: const MarkerId('LiveUserLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: userLiveLocation!),
                Marker(
                    infoWindow: InfoWindow(
                        snippet: 'Description', title: widget.idAsName),
                    markerId: MarkerId(widget.idAsName),
                    icon: customMarker ?? BitmapDescriptor.defaultMarker,
                    position: LatLng(widget.lat, widget.long)),
              },

              ///  It handles what happens when the map is fully initialized (rendered on the screen)
              /// This controller allows you to interact with
              // the map—like moving the camera, adding markers, drawing polylines, etc.
              onMapCreated: (controller) {
                ///[complete(controller)] The map is ready, and here’s the GoogleMapController you can use to control it.
                googleMapController.complete(controller);
              },

              /// polylines will draw the routes in the google map
              polylines: Set<Polyline>.of(polyLines.values),
            ),
    );
  }

  Future<void> getLocation() async {
    /// Checks if the device's location services (like GPS) are turned on.
    bool isServiceEnabled;
    isServiceEnabled = await locationController.serviceEnabled();

    if (isServiceEnabled) {
      /// If services are not enabled, it asks the user to enable the services
      isServiceEnabled = await locationController.requestService();
    } else {
      return;
    }

    /// check's if the app has permission to access the location
    PermissionStatus permissionStatus;
    permissionStatus = await locationController.hasPermission();

    /// if the app permission is denied it will request for the permission
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationController.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    /// [getLocation] it will fetch the user [LocationData]
    var a = await locationController.getLocation();
    currentLocation = LatLng(a.latitude ?? 0.0, a.longitude ?? 0);

    /// [onLocationChanged] it provide live tracking of the user stream
    locationController.onLocationChanged.listen(
      (LocationData locationData) {
        if (locationData.latitude != null && locationData.longitude != null) {
          setState(() {
            /// it will give the stream latlong when the user moves
            userLiveLocation =
                LatLng(locationData.latitude!, locationData.longitude!);

            /// and the same time it will adjust CameraPosition based the stram latlong
            changeCameraPosition(userLiveLocation!);
          });
        }
      },
    );
  }

  Future<void> changeCameraPosition(LatLng liveTargetPosition) async {
    /// [googleMapController] is likely a Completer<GoogleMapController> initialized when the map is created.
    ///
    /// [.future] it waits until the Google Map is fully initialized before proceeding
    ///
    /// [currentControllers] is now an instance of [GoogleMapController],
    // which is required to control map actions like moving the camera
    final currentControllers = await googleMapController.future;

    /// [CameraPosition] it will change the camera position based the new LatLong[liveTargetPosition]
    final camPos = CameraPosition(target: liveTargetPosition, zoom: 13);

    /// [animateCamera] Uses the [GoogleMapController] to animate the map camera smoothly to the new CameraPosition
    await currentControllers
        .animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  Future<List<LatLng>> generatePolylineCoordinates() async {
    /// Creates an empty list to store the coordinates of the route
    /// later it will user to draw route on the map
    List<LatLng> polylineCoordinates = [];

    try {
      /// Initialize [PolylinePoints] & Make API Request:

      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult response = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: "AIzaSyBLHGY723AqqCk9t_hyDK22Ryn2f7NIj9Y",
        request: PolylineRequest(

            /// [origin] - starting point
            origin: PointLatLng(
                currentLocation!.latitude, currentLocation!.longitude),

            /// [destination] - ending points
            destination: PointLatLng(widget.lat, widget.long),
            mode: TravelMode.driving),
      );

      if (response.points.isNotEmpty) {
        /// [response] it will return list of coordinates points between the two starting and endpoint
        /// and that points where stored in [polylineCoordinates]
        polylineCoordinates.addAll(response.points
            .map((point) => (LatLng(point.latitude, point.longitude))));
      }
    } catch (e) {
      print('error occure while direction api: $e');
    }

    /// [polylineCoordinates] will return the List<LatLng> it used to draw the route
    return polylineCoordinates;
  }

  void generatePloylineRoute(List<LatLng> polylineCoordinates) {
    /// Initializes id to the [PolylineId], for single route i have hardcoded,
    /// if you dealing with multiple route then the id will be different
    PolylineId polylineId = PolylineId('id');

    /// [Polyline] it draw a line on the map with help of [List<LatLng> polylineCoordinates]
    Polyline polyline = Polyline(
      polylineId: polylineId,
      points: polylineCoordinates,
      color: COLOR_BLACK,
      width: 8,
    );
    setState(() {
      /// i am passing this [polyline] to the map < polyLines[polylineId] >
      polyLines[polylineId] = polyline;
    });
  }
}
