import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.pressed,
  });
  final String text;
  final Color backgroundColor;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // orange color
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            // fontFamily: 'GoogleSansCode',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => context.go("/login"),

        child: Text(text),
      ),
    );
  }
}
