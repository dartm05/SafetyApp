import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menopause_app/src/features/chat/services/chat_service.dart';
import 'package:menopause_app/src/features/tripForm/providers/trip_form_provider.dart';
import 'package:provider/provider.dart';

import '../core/providers/auth_provider.dart';
import '../core/providers/error_provider.dart';
import '../core/providers/modal_provider.dart';
import '../core/services/http_service.dart';
import '../core/widgets/modal.dart';
import '../features/chat/providers/chat_provider.dart';
import '../features/chat/screens/chat.dart';
import '../features/tripForm/screens/trip_form.dart';
import '../features/home/widgets/nav_drawer.dart';
import '../features/login/screens/login.dart';
import '../features/login/screens/register.dart';
import '../features/profile/screens/profile.dart';
import '../features/tripForm/services/trip_service.dart';

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
            body: Stack(
              children: [
                child,
                Consumer<ErrorProvider>(
                  builder: (context, modalProvider, child) {
                    final modal = modalProvider.error;
                    if (modal != null) {
                      return ModalWidget(
                        modal: modal,
                        modalProvider: context.read<ModalProvider>(),
                        errorProvider: context.read<ErrorProvider>(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            name: 'chat',
            path: '/chat',
            builder: (context, state) => ChangeNotifierProvider(
              create: (context) => ChatProvider(
                  chatService: ChatService(
                httpServiceProvider: HttpServiceProvider(
                  httpService: HttpService(),
                ),
                errorProvider: context.read<ErrorProvider>(),
                userProvider: context.read<AuthenticationProvider>(),
              )),
              child: const Chatbot(),
            ),
          ),
          GoRoute(
              name: 'tripForm',
              path: '/tripForm',
              builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => TripFormProvider(
                      tripService: TripService(
                        errorProvider: context.read<ErrorProvider>(),
                      ),
                    ),
                    child: const TripFormPage(),
                  )),
          GoRoute(
            name: 'profile',
            path: '/profile',
            builder: (context, state) => const ProfileForm(),
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
