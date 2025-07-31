import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/main.dart';
import 'package:simple_chat_app/screens/welcome_page.dart';

void main() => runApp(const HatChat());

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage();
      },
    ),
  ],
);
