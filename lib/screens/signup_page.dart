import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/constants/colors.dart';
import 'package:simple_chat_app/cubit/auth_cubit.dart';
import 'package:simple_chat_app/gen/assets.gen.dart';
import 'package:simple_chat_app/widgets/custom_text_filed.dart';
import 'package:simple_chat_app/widgets/my_button.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.mainColor,
                  const Color.fromARGB(255, 1, 75, 121),
                ],
              ),
            ),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                        // flex: 3,
                        child: Center(
                          child: Assets.lib.assets.images.wightBlack.image(),
                        ),
                      ),
                      Expanded(
                        // flex: 5,
                        child: Card(
                          color: Colors.white,
                          // elevation: 50,
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Email field
                                CustomTextField(
                                  controller: emailController,
                                  hint: "Email",
                                ),
                                const SizedBox(height: 20),

                                CustomTextField(
                                  controller: passwordController,
                                  hint: "Password",
                                ),

                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: MyButton(
                                    text: "Sign up",
                                    backgroundColor: Colors.black,
                                    pressed: () {
                                      context.read<AuthCubit>().signUp(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text("Alread have account?"),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () => context.go("/login"),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
