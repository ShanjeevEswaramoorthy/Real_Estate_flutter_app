import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyData {
  final String address;
  final int bathRooms;
  final int bedRooms;
  final String image;
  final GeoPoint? location;
  final int price;
  final String propertyName;
  final String description;
  final int area;
  final int garage;

  PropertyData(
      {required this.address,
      required this.bathRooms,
      required this.bedRooms,
      required this.image,
      this.location,
      required this.price,
      required this.propertyName,
      required this.area,
      required this.description,
      required this.garage});

  factory PropertyData.fromJson(
      Map<String, dynamic> json, SnapshotOptions? options) {
    return PropertyData(
      address: json['address'],
      bathRooms: json['bathRooms'],
      bedRooms: json['bedRooms'],
      image: json['image'],
      location: json['location'] != null
          ? json['location'] as GeoPoint
          : const GeoPoint(
              0, 0), // Handle GeoPoint // Provide a default empty list
      price: json['price'],
      propertyName: json['propertyName'],
      area: json['area'],
      description: json['description'],
      garage: json['garage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'bathRooms': bathRooms,
      'bedRooms': bedRooms,
      'image': image,
      'location': location,
      'price': price,
      'propertyName': propertyName,
      'area': area,
      'description': description,
      'garage': garage,
    };
  }
}
