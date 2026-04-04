import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>{

  bool isLoading = true;
  String? errorMessage; //null safety
  
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Column(
          children: [
            Text("TEST1"),
            Text("TEST2")
          ],
        ),
      ),
    );
  }

  
}
  