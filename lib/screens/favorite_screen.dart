import 'package:flutter/material.dart';
import 'package:nasa_space_story/models/favorite_note.dart';
import 'package:nasa_space_story/screens/note_detail_screen.dart';
import 'package:nasa_space_story/services/database_service.dart';
import 'package:nasa_space_story/widgets/custom_input_modal.dart';


class Favscreen extends StatefulWidget{
    const Favscreen({super.key});
    @override
    State<Favscreen> createState() => _FavscreenState();
}

class _FavscreenState extends State<Favscreen>{

 final DatabaseService _dbService = DatabaseService();
 List<FavoriteNote> _Favnote = [];

 @override
  void initState(){
    super.initState();
    _loadNote();
  }

  void _loadNote(){
    setState(() {
      _Favnote = _dbService.getAllNote();
    });
  }

  Future<void> _deleteNote(String date) async{
    try{
      await _dbService.deleteNote(date);
    }
    catch(e){
      debugPrint("Something wrong on Fav screen deleteNote : $e");
    }
    _loadNote();
  }

  void _showEditModal(FavoriteNote oldNote) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomInputModal(
          //ส่งข้อความเดิมไปให้ Modal แสดงผล
          inputText: oldNote.userNote, 
          
          onSubmit: (String newText) async {
            // เปลี่ยนแค่ userNote เป็นข้อความใหม่ที่เพิ่งพิมพ์
            final updatedNote = FavoriteNote(
              date: oldNote.date,
              title: oldNote.title,
              imgURL: oldNote.imgURL,
              userNote: newText,
            );

            // สั่งเซฟ
            await _dbService.saveNote(updatedNote);

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Done Update!')),
              );
              _loadNote();
            }
          },
        );
      },
    );
  }

  void _ShowConfirmDialog (String date) {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Your note will be deleted'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text('Cancle')
            ), 
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                _deleteNote(date);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deleted')),
                );
              }, 
              child: const Text('Confirm', style: TextStyle(color: Colors.red),)
            ),
          ],
        );
      },
    );
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Journal')),
      
      //ถ้า List ว่างเปล่า ให้โชว์ข้อความ
      body: _Favnote.isEmpty
          ? const Center(child: Text('Seem like you dont have any journal yet!'))

          // ถ้ามีข้อมูลวนลูปสร้างขึ้นมาโชว์
          : ListView.builder(
              itemCount: _Favnote.length,
              itemBuilder: (context, index) {
                // ดึงข้อมูลโน้ตออกมาทีละ 1 ตาม index
                final note = _Favnote[index];
              
              return ListTile(
                leading: Hero(
                  tag: note.date,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(note.imgURL, 
                    fit: BoxFit.cover,
                    cacheWidth: 200,
                    ),
                  ),
                ),
                title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                subtitle: Text(note.date),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Change Your Note',
                      onPressed : () => _showEditModal(note), 
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(width: 15),
                    IconButton(
                      tooltip: 'Delete Your Note',
                      onPressed: () => _ShowConfirmDialog(note.date), 
                      icon: Icon(Icons.delete),
                    ),
                  ]
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailScreen(note: note),
                    ),
                  );
                }, 
              );
          },
        ),
    );
  }
}
