import 'package:flutter/material.dart';
import 'package:nasa_space_story/widgets/spacecard.dart';
import 'package:nasa_space_story/services/api_service.dart';
import 'package:nasa_space_story/models/apod_entry.dart';
import 'package:intl/intl.dart';

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

  /// ดึงข้อมูล
  Future<void> _fetchData({String? date}) async{
    //อัปเดตหน้าจอเป็น loading และเคลียร์ Error เก่า
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try{
      // ส่งวันที่ไปและเรียก api พร้อมรอจนเสร็จ
      _spaceData = await ApiService().fetchData(date: date);
    } catch(e){
          errorMessage = e.toString();
          print('Something wrong : $e');
        }
      finally{
        //อัปเดตหน้าจอเป็น !loading
        setState(() {
        isLoading = false;
        });
      }
  }
  /// Datepicker / ส่งวันที่ไปที่ _fetchData
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1995, 6, 16), //วันแรกสุดของ APOD จาก nasa
      lastDate: DateTime.now(),
    );
    if(pickedDate != null){
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      _fetchData(date: formattedDate);
    }
    setState(() {
      _selectedDate = pickedDate;
    });
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
              print('why'); //for testing button
            }, 
            icon: Icon(Icons.book))
        ],
      ),
      body: isLoading
          //เช็ค loading ถ้ากำลังโหลดให้แสดงหน้ากำลังโหลด
          ? const Center(
            child: CircularProgressIndicator()
          )
      : SingleChildScrollView(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_spaceData != null) 
              SpaceCard(
                imgURL: _spaceData!.imageURL, 
                title: _spaceData!.title,
                explanation: _spaceData!.explanation,
                copyright: _spaceData!.copyright,
                date: _spaceData!.date,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                          tooltip: 'Change date',
                          onPressed: (){_selectDate();}, 
                          icon: Icon(Icons.calendar_today),
                    ),
                  Text('Change Date'),
                  SizedBox(width: 30),
                  IconButton(
                          tooltip: 'SAVE',
                          onPressed: (){print("TEST SAVE");}, 
                          icon: Icon(Icons.favorite),
                    ),
                  Text("Save"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
