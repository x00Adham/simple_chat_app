import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/main.dart';
import 'package:simple_chat_app/screens/Signup_page.dart';
import 'package:simple_chat_app/screens/home_page.dart';
import 'package:simple_chat_app/screens/login_page.dart';
import 'package:simple_chat_app/screens/profile_page.dart';
import 'package:simple_chat_app/screens/settings_page.dart';
import 'package:simple_chat_app/screens/welcome_page.dart';
import 'package:simple_chat_app/services/auth_gate.dart';

void main() => runApp(const ChatApp());

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const AuthGate();
      },
    ),
    GoRoute(
      path: "/welcome",
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage();
      },
    ),
    GoRoute(
      path: "/login",
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) {
        return SignupPage();
      },
    ),
    GoRoute(
      path: "/home",
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: "/settings",
      builder: (BuildContext context, GoRouterState state) {
        return SettingsPage();
      },
    ),
    GoRoute(
      path: "/profile",
      builder: (BuildContext context, GoRouterState state) {
        return ProfilePage();
      },
    ),
  ],
);
