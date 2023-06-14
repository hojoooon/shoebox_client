import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../const/globals.dart' as globals;

Future<void> loadJsonData() async {
  final jsonString = await rootBundle.loadString('asset/shoes_data.json');
  final data = jsonDecode(jsonString);
  // Use the parsed JSON data as needed
  globals.Globals.shoesData = data;
}
