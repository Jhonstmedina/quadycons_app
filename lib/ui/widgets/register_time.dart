import 'package:flutter/material.dart';

class RegisterTime extends StatelessWidget {
  final String title;
  final String text;

  const RegisterTime({
    super.key,
    required this.title,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14
          )
        ),
        SizedBox(height: 4),
        TextField(
          readOnly: true,
          controller: TextEditingController(text: text),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF5F3FF),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none
            )
          )
        )
      ]
    );
  }
}
