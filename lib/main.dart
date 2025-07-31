import 'package:flutter/material.dart';
import 'package:simple_chat_app/utils/router/router.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const HatChat());
}

class HatChat extends StatelessWidget {
  const HatChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(routerConfig: router);
      },
    );
  }
}
