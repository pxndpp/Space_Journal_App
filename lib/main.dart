import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nasa_space_story/models/favorite_note.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  //ตรวจสอบว่า Binding ของ Flutter พร้อมทำงาน
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteNoteAdapter());
  await Hive.openBox<FavoriteNote>('fav_noted_Box');
  ThemeData(fontFamily: GoogleFonts.exo2().fontFamily);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Journal',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          //เปลี่ยนสีปุ่ม back
          iconTheme: IconThemeData(
            color: HexColor("#E0AAFF")
          ),
        ),
        fontFamily: GoogleFonts.exo2().fontFamily, 
      ),
      
      home: const HomeScreen(),
    );
  }
}
