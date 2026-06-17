import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  final String label;
  final String? errorMessage;
  final bool obscureText;
  final TextEditingController controller;

  const AuthInput({
    required this.label,
    required this.controller,
    this.errorMessage,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14
          )
        ),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            errorText: errorMessage
          )
        )
      ]
    );
  }
}
