import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_space_story/models/favorite_note.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteDetailScreen extends StatelessWidget {
  final FavoriteNote note;

  const NoteDetailScreen({super.key, required this.note});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#0E0E0E"),
      appBar: AppBar(
        title: Text(note.date, style: GoogleFonts.spaceMono(color: HexColor("#F0E6FF"))),
        systemOverlayStyle: SystemUiOverlayStyle.light, // ไว้ปรับพวก icon status bar ด้านบนให้มองเห็น
        flexibleSpace: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor("#0B0B1E"),
              HexColor("#1A0B2E"),
              HexColor("#2D1B4E")
            ],
          ),
        ),
        ),
        ),
      body: Container(
        width: double.infinity,
        height: double.infinity, // ให้ Container กว้างและสูงเต็มจอ
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor("#0B0B1E"),
              HexColor("#1A0B2E"),
              HexColor("#2D1B4E")
            ],
          ),
        ),
        child: SingleChildScrollView(
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
                      style: GoogleFonts.spaceMono(fontSize: 24, fontWeight: FontWeight.bold, color: HexColor("#F0E6FF")),
                    ),
                    Text(
                      note.title,
                      style: GoogleFonts.spaceMono(fontSize: 24, fontWeight: FontWeight.bold, color: HexColor("#E0AAFF").withValues(alpha: 0.8)),
                    ),
                    const SizedBox(height: 15,),
                    Text("Your note : ", style: GoogleFonts.spaceMono(fontSize: 15, color: HexColor("#F0E6FF"))),                  
                    Text(
                        note.userNote ?? 'No note clip to this one!',
                        style: GoogleFonts.spaceMono(fontSize: 18, color: HexColor("#E0AAFF").withValues(alpha: 0.8)),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}