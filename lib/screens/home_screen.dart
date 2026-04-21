import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_space_story/screens/favorite_screen.dart';
import 'package:nasa_space_story/widgets/custom_input_modal.dart';
import 'package:nasa_space_story/models/favorite_note.dart';
import 'package:nasa_space_story/services/database_service.dart';
import 'package:nasa_space_story/widgets/spacecard.dart';
import 'package:nasa_space_story/services/api_service.dart';
import 'package:nasa_space_story/models/apod_entry.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';

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
  final DatabaseService _dbService = DatabaseService();
  bool isSaved = false; // ไว้ใช้เช็คค่าให้ปุ่ม save เปิดปิด
  
  @override
  void initState() {
    super.initState();
    //รอให้หน้าจอ Render เฟรมแรกเสร็จก่อน แล้วค่อยเรียก API
    WidgetsBinding.instance.addPostFrameCallback((_){
    _fetchData();
    });
  }

  /// ดึงข้อมูล
  Future<void> _fetchData({String? date}) async{
    //อัปเดตหน้าจอเป็น loading และเคลียร์ Error เก่า
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try{
      // ส่งวันที่ไปและเรียก api พร้อมรอจนเสร็จ
      _spaceData = await ApiService().fetchData(date: date);
      //เช็คว่ารูปของวันที่ส่งค่าไปเซฟแล้วยัง
      isSaved = _dbService.isSaved(_spaceData!.date);
    } catch(e){
          errorMessage = 'Look like ours engine is down!, Let wait for a few minute';
          debugPrint('Something wrong : $e');
        }
      finally{
        //อัปเดตหน้าจอเป็น !loading
        // เช็คว่าหน้าจอยังเปิดอยู่ไหมก่อนสั่ง setState
        if (!mounted) return; 
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
    if (!mounted) return;
    if(pickedDate != null){
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      debugPrint("formattedDate");
      setState(() {
      _selectedDate = pickedDate; 
      });
      _fetchData(date: formattedDate);
    }
  }
  /// save ลง DB ด้วยการรับค่าที่คืนมาจาก textdield ในตัว modal แล้วมาปั้นเป็น obj ยัดลง database
  Future<void> _saveToDatabase({String? u_note}) async{
    if (_spaceData == null) return;

    final note = FavoriteNote(
      date: _spaceData!.date, 
      title: _spaceData!.title, 
      imgURL: _spaceData!.imgURL, 
      userNote: u_note); // ดึงค่าจากตัวที่พิมพ์ใน Modal

      try {
        await _dbService.saveNote(note);
        isSaved = _dbService.isSaved(_spaceData!.date);
      } catch (e) {
        debugPrint("something wrong in DB service : $e");
      }
      if (mounted) {
        setState(() {
          isSaved = _dbService.isSaved(_spaceData!.date);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SAVED')),
        );
      }
  }

////// Widget zone //////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Space_logo_bar.png', fit: BoxFit.contain, height: 55,),
        systemOverlayStyle: SystemUiOverlayStyle.light, // ไว้ปรับพวก icon status bar ด้านบนให้มองเห็น
        flexibleSpace: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor("#D3045D").withValues(alpha: 0.7),
              HexColor("#C77DFF").withValues(alpha: 0.5),
              HexColor("#0C287B").withValues(alpha: 0.7)
            ],
          ),
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            //กดสลับไปหน้า Fav list รอให้ปิดหน้าแล้วเช็คเซฟใหม่
            onPressed: () async{
              //ถ้าโหลดเสร็จให้กดได้ กันระเบิด
              isLoading ? null :
              await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Favscreen()),
              );
              if (mounted) {
                setState(() {
                  isSaved = _dbService.isSaved(_spaceData!.date);
                });
              }
            }, 
            icon: Icon(Icons.book, color: HexColor("#2B384C"),))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity, // ให้ Container กว้างและสูงเต็มจอ
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor("#D3045D"),
              HexColor("#0C8EF4")..withValues(alpha: 0.2),
              HexColor("#A162A1").withValues(alpha: 0.5)
            ],
          ),
        ),
        child: isLoading
            //เช็ค loading ถ้ากำลังโหลดให้แสดงหน้ากำลังโหลด
            ? const Center(
              child: CircularProgressIndicator()
            )
        : errorMessage != null 
          ? Center( 
            //ถ้ามี Error โชว์แค่ Error Message กับปุุ่ม change date
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,),
                    const SizedBox(height: 16),
                    IconButton(
                            tooltip: 'Change date',
                            onPressed: (){_selectDate();}, 
                            icon: Icon(Icons.calendar_today),
                      ),
                    Text('Select Date'),
                  ],
                ),
              ),
            )
        : SingleChildScrollView(
          child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_spaceData != null) 
                SpaceCard(
                  imgURL: _spaceData!.imgURL, 
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
                            icon: Icon(Icons.calendar_today, color: HexColor("#0C287B"),),
                      ),
                    Text('Change Date'),
                    SizedBox(width: 30),
                    IconButton(
                            tooltip: 'SAVE',
                            onPressed: (){
                              //เงื่อนไข ? ถ้าจริง : ถ้าเท็จ
                              isSaved ? null : 
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true, // เผื่อพิมพ์คีย์บอร์ดแล้วบังหน้าจอ
                                builder: (context) {
                                  return CustomInputModal(
                                    onSubmit: (String inputValue) {
                                      debugPrint("Input val: $inputValue");
                                      _saveToDatabase(u_note: inputValue);
                                    },
                                  );
                                },
                              );
                            }, icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border, color: HexColor("#D3045D")),
                      ),
                    Text(isSaved ? 'Saved' : 'Save'),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

