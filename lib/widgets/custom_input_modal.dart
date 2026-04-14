import 'package:flutter/material.dart';
class CustomInputModal extends StatefulWidget {
  // สร้าง Callback Function เพื่อส่งข้อมูลกลับไปให้หน้าหลัก
  final Function(String) onSubmit; 

  const CustomInputModal({super.key, required this.onSubmit});

  @override
  State<CustomInputModal> createState() => _CustomInputModalState();
}

class _CustomInputModalState extends State<CustomInputModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Let take a note!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'ํYour note here...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // ส่งข้อมูลกลับไป แล้วปิด Modal
                widget.onSubmit(_controller.text); 
                Navigator.pop(context); //
              },
              child: const Text('Save'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}