import 'package:flutter/material.dart';
import 'package:simple_chat_app/gen/assets.gen.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 50, 164, 251),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Center(child: Assets.lib.assets.images.wight.image()),
    );
  }
}

