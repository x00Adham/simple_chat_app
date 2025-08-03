import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/cubit/auth_cubit.dart';
import 'package:simple_chat_app/gen/assets.gen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Assets.lib.assets.images.blueBack.image(),
          // Divider(height: 5),
          GestureDetector(
            onTap: () {
              context.go("/home");
              Navigator.of(context).pop();
            },
            child: ListTile(
              leading: Icon(Icons.home, color: Colors.grey.shade800),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
            ),
          ),

          //*Profile
          GestureDetector(
            onTap: () {
              context.go("/profile");
              Navigator.of(context).pop();
            },
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.grey.shade800),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
            ),
          ),

          //*Settings
          GestureDetector(
            onTap: () {
              context.go("/settings");
              Navigator.of(context).pop();
            },
            child: ListTile(
              leading: Icon(Icons.settings, color: Colors.grey.shade800),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
            ),
          ),
          Spacer(),

          //*logout
          GestureDetector(
            onTap: () {
              context.read<AuthCubit>().logout();
              context.go("/welcome");
            },
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.grey.shade800),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
