// TODO: Service ไว้จัดการ CRUD

/*
CREATE: ในหน้า HomeScreen เมื่อเราดูภาพอวกาศแล้วถูกใจเราจะเพิ่มปุ่ม Save พร้อมช่องให้พิมพ์โน้ตสั้น ๆ เมื่อกดบันทึกข้อมูลจะถูกเขียนลง Database

READ: มีหน้า FavoritesList ที่ดึงข้อมูลทั้งหมดที่บันทึกไว้ใน Database มาแสดงผล

UPDATE: เมื่อกดที่รายการที่เราเคยบันทึกไว้จะเปิดหน้า EditNoteScreen เพื่อให้เราแก้ไขข้อความโน้ตที่เคยเขียนไว้ได้

DELETE: ในหน้ารายการบันทึกสามารถกดปุ่มถังขยะ หรือ ปัดนิ้วเพื่อลบบันทึกนั้นออกจากเครื่อง
*/

import 'package:flutter/rendering.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:nasa_space_story/models/favorite_note.dart';

class DatabaseService {
static const String boxName = 'fav_noted_box';
Box<FavoriteNote> get _box => Hive.box<FavoriteNote>(boxName);

Future<void> saveNote(FavoriteNote note) async {
    try {
        await _box.put(note.date, note); // key / value
    } catch (e) {
      debugPrint("Something wrong : $e");
    }
}

List<FavoriteNote> getAllNote() {
    return _box.values.toList();
}

Future<void> deleteNote(String date) async {
    try {
      await _box.delete(date);
    } catch (e) {
      debugPrint("Something wrong : $e");
    }
}

// เช็คสถานะเพื่อเปลี่ยนไอคอนปุ่ม Save/Unsave หน้า Home
bool isSaved(String date){
    return _box.containsKey(date);
    /// คืนค่ากลับมาเป็น true ถ้าเคย save หรือ false ถ้าไม่
}
}