import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Widget child;

  const Box({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 3,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: child
    );
  }
}
