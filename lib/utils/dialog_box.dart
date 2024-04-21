import 'package:flutter/material.dart';
import 'package:mini_project/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  
  final TextEditingController controller;
  final Function() ? onSave;
  final Function() ? onCancel;
  const DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        height: 140,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                hintText: "Add new task",
              ), 
            ),
            const SizedBox(height: 20,)
            ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(text: "Cancel", onPressed: onCancel),
                const SizedBox(width: 10,)
                ,
                MyButton(text: "Save", onPressed: onSave)
              ],
            )

          ],
        ),
      ),
    );
  }
}