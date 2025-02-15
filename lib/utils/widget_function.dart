import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

/// image or text [Uint8List] it does not coverty it into binary data,
// instead of it just show them in binary form
Future<Uint8List> getBytesFromAssetForAnimation(String path, int width) async {
  /// rootBundle is a global object in Flutter from the services.dart package
  // It allows access to files stored in the assets/ folder of your Flutter project

  /// this read file directly as bytes
  // The assets (like images, text, JSON) are already stored as raw bytes in your app’s package
  // rootBundle.load(path) fetches the file in its original binary (byte) format
  ByteData data = await rootBundle.load(path);

  /// it take the image raw bytes as an input and return the codec object - it will give you an individual frames of an image
  // bit for image it was only one frame but for animation it will retur multiple frames
  ui.Codec codec = await ui.instantiateImageCodec(
    /// [ data.buffer.asUint8List() ] this converts byte data into Uint8List
    data.buffer.asUint8List(),

    /// Helps optimize performance by loading only the required image size.
    targetWidth: width,
  );

  /// codec.getNextFrame() is used to get the first frame of the animated GIF,
  // once first frame render then async retrives the next frame from codec object
  ui.FrameInfo fi = await codec.getNextFrame();

  /// used to convert the byte data into specifc format like (jpg,png)
  ByteData? byteData =
      await fi.image.toByteData(format: ui.ImageByteFormat.png);

  /// it return the bytedata into unit8list
  return byteData!.buffer.asUint8List();
}

/// this function is only representing image to Uint8List
Future<Uint8List> getBytesFromAssetForImage(
  String path,
) async {
  ByteData byteData = await rootBundle.load(path);

  return byteData.buffer.asUint8List();
}

Future<Uint8List> getBytesFromNetworkImage(String url, int width) async {
  /// Fetch image from network
  /// converting a string into valid url and
  /// then doing the network call to get the image
  final response = await http.get(Uri.parse(url));

  print('Network image Url => ${Uri.parse(url)}');

  if (response.statusCode == 200) {
    Uint8List uint8list = response.bodyBytes;

    /// Decode image bytes into a format Flutter can use
    ui.Codec codec = await ui.instantiateImageCodec(
      uint8list,
      targetWidth: width,
    );

    /// Get the first frame
    ui.FrameInfo fi = await codec.getNextFrame();

    /// Convert the frame to Uint8List
    ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  } else {
    throw Exception("Failed to load image");
  }
}
