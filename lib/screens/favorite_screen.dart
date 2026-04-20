import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:nasa_space_story/models/favorite_note.dart';
import 'package:nasa_space_story/services/database_service.dart';

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
                AlertDialog(
                  title: Text('Deleted'),
                  content: Text('Your note is deleted'),
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
              
              //TODO: เปลี่ยนเป็น Card
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(note.imgURL, 
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                  ),
                ),
                title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(note.userNote ?? ''),
                trailing: IconButton(onPressed: (){_ShowConfirmDialog(note.date);}, icon: Icon(Icons.delete)),
              );
          },
        ),
    );
  }
}
