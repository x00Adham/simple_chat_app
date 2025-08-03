import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_app/constants/colors.dart';
import 'package:simple_chat_app/cubit/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.mainColor,
            title: Text("Home"),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              child: Text("Logout"),
            ),
          ),
        );
      },
    );
  }
}
