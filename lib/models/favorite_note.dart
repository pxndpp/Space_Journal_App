import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'favorite_note.g.dart'; //สำหรับ Generator สร้าง TypeAdapter

@HiveType(typeId: 0)
class FavoriteNote{
    @HiveField(0)
    final String date;
    @HiveField(1)
    final String title;
    @HiveField(2)
    final String imgURL;
    @HiveField(3)
    final String? userNote; //เผื่อให้เซฟแค่รูปแต่ไม่ต้องใส่โน๊ต

  FavoriteNote({
    required this.date, 
    required this.title, 
    required this.imgURL, 
    required this.userNote
  });


}
