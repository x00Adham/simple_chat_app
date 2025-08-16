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
          drawer: const CustomDrawer(),
          appBar: AppBar(
            title: const Text("Home"),
            centerTitle: true,
            elevation: 2,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: const SafeArea(child: _HomeBody()),
        );
      },
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserStream(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return _buildStateWidget(context, state);
        },
      ),
    );
  }

  Widget _buildStateWidget(BuildContext context, HomeState state) {
    return switch (state) {
      HomeLoading() => const _LoadingWidget(),
      HomeFailure() => _ErrorWidget(errorMessage: state.errorMessage),
      HomeSuccess() => _UserListWidget(users: state.users),
      HomeInitial() => const _LoadingWidget(),
    };
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading users...'),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String errorMessage;

  const _ErrorWidget({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeCubit>().refreshUsers();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const _UserListWidget({required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const _EmptyStateWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().refreshUsers();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _UserListItem(user: user);
        },
      ),
    );
  }
}

class _UserListItem extends StatelessWidget {
  final Map<String, dynamic> user;

  const _UserListItem({required this.user});

  @override
  Widget build(BuildContext context) {
    final email = user['email']?.toString() ?? 'No email';
    final homeCubit = context.read<HomeCubit>();
    final isCurrentUser = homeCubit.isCurrentUser(email);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        onTap: () => _navigateToChat(context, email),
        leading: CircleAvatar(
          backgroundColor:
              isCurrentUser
                  ? Colors.grey.shade300
                  : Theme.of(context).primaryColor,
          child: Icon(
            Icons.person,
            color: isCurrentUser ? Colors.grey.shade600 : Colors.white,
          ),
        ),
        title: Text(
          isCurrentUser ? "Me" : email.split('@')[0],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isCurrentUser ? Colors.grey.shade600 : null,
          ),
        ),
        subtitle:
            isCurrentUser
                ? const Text('Current user', style: TextStyle(fontSize: 12))
                : const Text(
                  'Tap to start chatting',
                  style: TextStyle(fontSize: 12),
                ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _navigateToChat(BuildContext context, String receiverEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(receiverEmail: receiverEmail),
      ),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No Users Found',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'There are no other users available to chat with.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeCubit>().refreshUsers();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
