import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
// TODO: import package สำหรับ Database (เช่น hive_flutter หรือ shared_preferences)

void main() async {
  // -----------------------------------------
  // 1. ส่วนเตรียมความพร้อมก่อนแอปเปิด (Initialization)
  // -----------------------------------------
  // บรรทัดนี้สำคัญมาก! ต้องใส่ไว้ถ้าเราจะทำอะไรกับระบบเครื่อง (เช่น Init DB) ก่อนสั่ง runApp
  WidgetsFlutterBinding.ensureInitialized(); 

  // TODO: ตั้งค่า Database ของคุณตรงนี้ (เช่น Hive.initFlutter() หรือเปิดกล่องข้อมูล)

  // -----------------------------------------
  // 2. สั่งรันแอปพลิเคชัน
  // -----------------------------------------
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // -----------------------------------------
    // 3. ส่วนตั้งค่าภาพรวมของแอป (App Configuration)
    // -----------------------------------------
    return MaterialApp(
      title: 'NASA Space Journal',
      debugShowCheckedModeBanner: false, // เอาแถบคาด Debug มุมขวาบนออกให้ดูโปรขึ้น

      // TODO: ตั้งค่า Theme ของแอป (เช่น ใช้ ThemeData.dark() เพื่อให้เข้ากับธีมอวกาศ)
      theme: ThemeData.dark().copyWith(
        appBarTheme: 
      ),

      // -----------------------------------------
      // 4. กำหนดหน้าแรก (Routing)
      // -----------------------------------------
      home: HomeScreen(), // ชี้เป้าไปที่หน้า HomeScreen ที่เราเพิ่งวางโครงกันไป
    );
  }
}