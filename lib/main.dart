import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async{
  //ตรวจสอบว่า Binding ของ Flutter พร้อมทำงาน
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox('fav_noted_Box');
  
  runApp(const MaterialApp(
    home: HomeScreen()
  ));
}
