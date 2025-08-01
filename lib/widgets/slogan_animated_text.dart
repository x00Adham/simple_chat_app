import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SloganAnimatedText extends StatelessWidget {
  const SloganAnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey.shade800,
          // fontFamily: 'GoogleSansCode',
        ),

        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              "Just You, Me, and Chat App.",
              speed: const Duration(milliseconds: 80),
            ),
          ],
        ),
      ),
    );
  }
}
