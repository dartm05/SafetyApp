import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menopause_app/features/chat/providers/chatProvider.dart';
import 'package:menopause_app/features/chat/screens/chat.dart';
import 'package:menopause_app/features/home/widgets/nav_drawer.dart';
import 'package:menopause_app/features/form/screens/form.dart';
import 'package:menopause_app/features/login/screens/login.dart';
import 'package:menopause_app/features/login/screens/register.dart';
import 'package:menopause_app/features/settings/screens/settings.dart';
import 'package:provider/provider.dart';

import '../core/services/auth_provider.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ShellRoute(
        builder: (context, state, child) {
          final authProvider = Provider.of<AuthenticationProvider>(context);
          final showDrawer = authProvider.isAuthenticated &&
              state.path != '/login' &&
              state.path != '/register';
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.grey,
            ),
            drawer: showDrawer ? const CustomDrawer() : null,
            body: child,
          );
        },
        routes: [
          GoRoute(
            name: 'chat',
            path: '/chat',
            builder: (context, state) => ChangeNotifierProvider(
              create: (context) => ChatProvider(),
              child: const Chatbot(),
            ),
          ),
          GoRoute(
            name: 'form',
            path: '/form',
            builder: (context, state) => const FormPage(),
          ),
          GoRoute(
            name: 'settings',
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            name: 'login',
            path: '/login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            name: 'register',
            path: '/register',
            builder: (context, state) => const RegisterForm(),
          ),
        ])
  ],
);
