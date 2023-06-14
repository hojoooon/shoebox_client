import 'package:flutter/material.dart';
import 'package:shoe_box_client/api/get_shoes_data.dart';
import 'package:shoe_box_client/screen/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadJsonData();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      title: 'shoeBOX',
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
    ),
  );
}
