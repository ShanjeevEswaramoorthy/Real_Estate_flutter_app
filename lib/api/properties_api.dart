import 'dart:convert';

import 'package:flutter/services.dart';

import 'properties_response.dart';

class PropertiesApi {
  Future<PropertyList> loadProperties() async {
    /// [rootBundle.loadString] it is used to load the textfile in the asset folder and return a string
    ///
    String jsonString = await rootBundle.loadString('assets/sample_data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    return PropertyList.fromJson(jsonData);
  }
}
