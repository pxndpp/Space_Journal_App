import 'package:flutter/material.dart';
import 'package:nasa_space_story/models/favorite_note.dart';

class NoteDetailScreen extends StatelessWidget {
  final FavoriteNote note;

  const NoteDetailScreen({super.key, required this.note});
  
Color hexToColor(String code) { // func เอาไว้แปลง hex เป็นสี
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#403963"),
      appBar: AppBar(
        title: Text(note.date),
        backgroundColor: Colors.transparent,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: note.date, //date เป็น Tag เพราะมันไม่ซ้ำกัน
              child: Image.network(
                note.imgURL,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.date,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    note.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15,),
                  Text('Your note : ', style: const TextStyle(fontSize: 15, color: Colors.blueAccent)),
                  Text(
                    note.userNote ?? 'No note clip to this one!',
                    style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 15,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}