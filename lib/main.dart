import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// TODO: import package สำหรับ Database (เช่น hive_flutter หรือ shared_preferences)

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MaterialApp(
    home: HomeScreen()
  ));
}
