import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/api/firebase_api.dart';
import 'package:real_estate_app/api/firebase_property_response.dart';
import 'package:real_estate_app/custom/custom_drop_down.dart';
import 'package:real_estate_app/custom/text_form_field.dart';
import 'package:real_estate_app/utils/constant.dart';
import 'package:real_estate_app/utils/widget_function.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddPostFormUi extends StatefulWidget {
  const AddPostFormUi({super.key});

  @override
  State<AddPostFormUi> createState() => _AddPostFormUiState();
}

class _AddPostFormUiState extends State<AddPostFormUi> {
  final _formKey = GlobalKey<FormState>();

  final addressController = TextEditingController();

  final priceController = TextEditingController();

  final areaController = TextEditingController();

  final garageController = TextEditingController();

  final descriptionController = TextEditingController();

  final latController = TextEditingController();

  final longController = TextEditingController();

  final propertyNameController = TextEditingController();

  FilePickerResult? filePickerResult;

  String? imagePath;

  Uint8List? originalImageSize;

  Uint8List? compressImageSize;

//  var finalImages;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final api = FirebaseApi();
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: COLOR_WHITE,
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: Text(
              'Property Ad post form',
              style: themeData.textTheme.displayMedium,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    title: 'Property Name',
                    textStyle: themeData.textTheme.bodyMedium,
                    controller: propertyNameController,
                    errorText: 'Field should not be empty',
                    inputFormater: FilteringTextInputFormatter.allow(
                        RegExp(r'^[a-zA-Z\s]+$')),
                  ),
                  CustomTextFormField(
                    title: 'Property Address',
                    textStyle: themeData.textTheme.bodyMedium,
                    controller: addressController,
                    errorText: 'Field should not be empty',
                    inputFormater: FilteringTextInputFormatter.allow(
                        RegExp(r'^[a-zA-Z\s]+$')),
                  ),
                  addVerticalSpace(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: CustomTextFormField(
                          title: 'Price of the Property',
                          textStyle: themeData.textTheme.bodyMedium,
                          controller: priceController,
                          errorText: 'Field should not be empty',
                          inputFormater: FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]+$')),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: CustomTextFormField(
                          title: 'Area of the Property',
                          textStyle: themeData.textTheme.bodyMedium,
                          controller: areaController,
                          errorText: 'Field should not be empty',
                          inputFormater: FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]+$')),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: CustomTextFormField(
                          title: 'Latitude',
                          textStyle: themeData.textTheme.bodyMedium,
                          controller: latController,
                          errorText: 'Field should not be empty',
                          inputFormater: FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]+$')),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: CustomTextFormField(
                          title: 'Longitude',
                          textStyle: themeData.textTheme.bodyMedium,
                          controller: longController,
                          errorText: 'Field should not be empty',
                          inputFormater: FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]+$')),
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    title: 'Description',
                    textStyle: themeData.textTheme.bodyMedium,
                    controller: descriptionController,
                    errorText: 'Field should not be empty',
                    inputFormater: FilteringTextInputFormatter.allow(
                        RegExp(r'^[a-zA-Z\s]+$')),
                  ),
                  addVerticalSpace(20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropDown(
                        hintText: 'Bed Room Count',
                      ),
                      CustomDropDown(
                        hintText: 'Bath Room Count',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (compressImageSize != null &&
                      compressImageSize!.isNotEmpty)
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Image.memory(compressImageSize!),
                    ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        filePickerResult = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['jpeg', 'jpg', 'png']);
                        if (filePickerResult != null) {
                          comperssImage(filePickerResult?.paths[0]);
                        }
                      },
                      child: const Card(
                        color: COLOR_BLACK,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'UpLoad Images',
                            style: TextStyle(
                                color: COLOR_WHITE,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (originalImageSize != null)
                    Card(
                      child: Text('${originalImageSize!.length / 1000} kb'),
                    ),
                  if (compressImageSize != null)
                    Card(
                      child: Text('${compressImageSize!.length / 1000} kb'),
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              // _formKey.currentState?.validate();
              api.addPropertyDocument(PropertyData(
                  address: addressController.text,
                  bathRooms: 2,
                  bedRooms: 3,
                  image: '',
                  // 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fsingle-family-home&psig=AOvVaw2ZlvAs-ZHZA5-rm1FXi8gV&ust=1739286186681000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIDVtYywuYsDFQAAAAAdAAAAABAE',
                  // location: GeoPoint(double.parse(latController.text),
                  //     double.parse(longController.text)),
                  price: int.parse(priceController.text),
                  propertyName: propertyNameController.text,
                  area: int.parse(areaController.text),
                  description: descriptionController.text,
                  garage: 1));
            },
            child: BottomAppBar(
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text(
                  'POST YOUR PROPERTY',
                  style: themeData.textTheme.displayMedium,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void comperssImage(path) async {
    /// [File] it will change the directory to the current path
    /// [readAsBytesSync] it will read the entire file content in [Uint8List] bytes
    var bytes = File(path).readAsBytesSync();

    /// [FlutterImageCompress.compressWithList] it will compress image and return the [Uint8List] bytes
    compressImageSize =
        await FlutterImageCompress.compressWithList(bytes, quality: 10);
    setState(() {});

    /// Converts the compressed image bytes (Uint8List) into a Base64 string.
    /// This can be useful if you need to store or send the image as a text string (e.g., saving to Firestore, sending via API).
    // final decodeImage = base64Encode(compressImageSize);

    /// Converts the Base64 string back into Uint8List bytes
    /// You can then render it in Image.memory(finalImages).
    // finalImages = base64Decode(decodeImage);
  }
}
