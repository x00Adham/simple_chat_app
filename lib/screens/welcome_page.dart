import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/constants/colors.dart';
import 'package:simple_chat_app/widgets/my_button.dart';
import 'package:simple_chat_app/widgets/logo_container.dart';
import 'package:simple_chat_app/widgets/slogan_animated_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 3, child: LogoContainer()),
          // SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SloganAnimatedText(),
                  Spacer(),
                  Column(
                    children: [
                      MyButton(
                        text: "Login",
                        backgroundColor: MyColors.mainColor,
                        pressed: () => GoRoute(path: "/login"),
                      ),
                      SizedBox(height:10 ,),
                      MyButton(
                        text: "Sign Up",
                        backgroundColor: MyColors.mainColor,
                        pressed: () => GoRoute(path: "/signup"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Text("More than a Chat App"),
                  // Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
