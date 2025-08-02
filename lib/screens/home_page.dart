import 'package:flutter/material.dart';
import 'package:simple_chat_app/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainColor,
        title: Text("Home"),
      ),
      
    );
  }
}