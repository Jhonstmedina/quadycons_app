import 'package:flutter/material.dart';
import 'auth_input.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String? errorMessage;

  const PasswordInput({
    super.key,
    required this.controller,
    this.errorMessage,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthInput(
          label: 'Contraseña',
          controller: widget.controller,
          obscureText: obscureText,
          errorMessage: widget.errorMessage,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              obscureText ?
                Icons.visibility :
                Icons.visibility_off,
              color: Colors.black54
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
      ],
    );
  }
}
