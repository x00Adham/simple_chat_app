import 'package:flutter/material.dart';
import 'package:simple_chat_app/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hint, required this.controller});
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isPassword = hint.toLowerCase().contains("password");
        // Use a local variable to track obscureText state
        // (since StatelessWidget, use StatefulBuilder for local state)
        // We'll use a ValueNotifier for this
        final obscureNotifier = ValueNotifier<bool>(isPassword);
       

        return ValueListenableBuilder<bool>(
          valueListenable: obscureNotifier,
          builder: (context, obscureText, _) {
            return TextField(
              controller: controller,
              obscureText: isPassword ? obscureText : false,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.mainColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: isPassword
                    ? Icon(Icons.lock)
                    : (hint.toLowerCase().contains("email") || hint.toLowerCase().contains("mail"))
                        ? Icon(Icons.person)
                        : null,
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          obscureNotifier.value = !obscureNotifier.value;
                        },
                      )
                    : null,
              ),
              keyboardType: TextInputType.text,
            );
          },
        );
      },
    );
  }
}
