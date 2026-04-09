import 'package:flutter/material.dart';
import 'package:nasa_space_story/widgets/SpaceCard.dart';
import 'package:nasa_space_story/services/api_service.dart';
import 'package:nasa_space_story/models/apod_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>{

  bool isLoading = true;
  String? errorMessage; //null safety
  ApodEntry? _spaceData; //เก็บข้อมูลที่ได้จาก API
  DateTime? _selectedDate; //เก็บวันที่ user เลือก
  
  @override
  void initState() {
    super.initState();
    // เปิดหน้านี้ขึ้นมาสั่งดึงข้อมูลทันที
    _fetchData(); 
  }

  Future<void> _fetchData({String? date}) async{
    //อัปเดตหน้าจอเป็น loading และเคลียร์ Error เก่า
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try{
      // ส่งวันที่ไปและเรียก api พร้อมรอจนเสร็จ
      _spaceData = await ApiService().fetchData(date: date);
      //อัปเดตหน้าจอเป็น !loading
      setState(() {
        isLoading = false;
      });
    } catch(e){
        setState(() {
          isLoading = false;
          print('Something wrong : $e');
          errorMessage = e.toString();
          print('Something wrong : $e');
        });
        
    }
  }



  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("NASA JOURNAL"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              print('why');
            }, 
            icon: Icon(Icons.book))
        ],
      ),
      body: SingleChildScrollView(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpaceCard(imgURL: 'https://picsum.photos/250?image=9', title: 'TEST',),
            Text("TEST3")

          ],
        ),
      ),
      ),
    );
  }

  
}
  