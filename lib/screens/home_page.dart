import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_app/cubit/auth_cubit.dart';
import 'package:simple_chat_app/screens/chat_page.dart';
import 'package:simple_chat_app/services/auth_service.dart';
import 'package:simple_chat_app/services/chat_Service.dart';
import 'package:simple_chat_app/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(title: Text("Home"), centerTitle: true),
          body: SafeArea(
            child: StreamBuilder(
              stream: chatService.getUserStream(),

              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Text('Loading...');
                }
                final users = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final email = user['email']?.toString() ?? 'No email';
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ListTile(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ChatPage(receiverEmail: email),
                              ),
                            ),
                        leading: CircleAvatar(child: Icon(Icons.person)),
                        title:
                            authService.getCurrentuser()?.email?.toString() ==
                                    email
                                ? Text("me")
                                : Text(email),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
