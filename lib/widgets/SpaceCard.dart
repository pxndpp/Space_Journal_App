import 'package:flutter/material.dart';

class SpaceCard extends StatelessWidget {
  final String imgURL;
  final String title;
  const SpaceCard({super.key, required this.imgURL, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20), // เว้นระยะห่างรอบตัวเงา
      padding: EdgeInsets.all(16), // เว้นระยะห่างระหว่างเงากับเนื้อหาข้างใน
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17), // ทำมุมมน
      boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // สีของเงา
            spreadRadius: 5, // การแผ่กระจายของเงา
            blurRadius: 7, // ความฟุ้งของเงา
            offset: Offset(0, 3), // ตำแหน่งเงา (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Image.network(imgURL),
          SizedBox(height: 16),
          Text(title),
        ],
      ),
    );
  }
}