import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat_app/cubit/auth_cubit.dart';
import 'package:simple_chat_app/cubit/home_cubit.dart';
import 'package:simple_chat_app/screens/chat_page.dart';
import 'package:simple_chat_app/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(title: Text("Home"), centerTitle: true),
          body: SafeArea(
            child: BlocProvider(
              create: (context) => HomeCubit()..getUserStream(),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is HomeFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${state.errorMessage}'),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<HomeCubit>().refreshUsers();
                            },
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is HomeSuccess) {
                    final users = state.users;
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final email = user['email']?.toString() ?? 'No email';
                        final homeCubit = context.read<HomeCubit>();

                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ListTile(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ChatPage(receiverEmail: email),
                                  ),
                                ),
                            leading: CircleAvatar(child: Icon(Icons.person)),
                            title:
                                homeCubit.isCurrentUser(email)
                                    ? Text("me")
                                    : Text(email),
                          ),
                        );
                      },
                    );
                  }

                  return Center(child: Text('No users found'));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
