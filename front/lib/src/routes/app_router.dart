import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safety_app/src/features/chat/services/chat_service.dart';

import 'package:provider/provider.dart';
import 'package:safety_app/src/features/trip_list/providers/trip_list_provider.dart';
import 'package:safety_app/src/features/trip_list/screens/trip_list_screen.dart';

import '../core/providers/auth_provider.dart';
import '../core/providers/error_provider.dart';
import '../core/providers/modal_provider.dart';
import '../core/services/http_service.dart';
import '../core/widgets/modal.dart';

import '../features/chat/providers/chat_provider.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/profile/providers/profile_provider.dart';
import '../features/trip_detail/screens/trip_details_screen.dart';
import '../features/home/widgets/nav_drawer.dart';
import '../features/login/screens/login.dart';
import '../features/login/screens/register.dart';
import '../features/profile/screens/profile.dart';
import '../features/trip_detail/screens/trip_places_screen.dart';
import '../features/trip_detail/services/trip_service.dart';

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
                Consumer<ModalProvider>(
                  builder: (context, modalProvider, child) {
                    final modal = modalProvider.modal;
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
            builder: (context, state) {
              return ChangeNotifierProvider.value(
                value: context.read<ChatProvider>(),
                child: const ChatScreen(),
              );
            },
          ),
          GoRoute(
              path: '/trips',
              builder: (context, state) {
                return ChangeNotifierProvider.value(
                    value: context.read<TripListProvider>(),
                    child: const TripListScreen());
              }),
          GoRoute(
              name: 'tripForm',
              path: '/tripForm',
              builder: (context, state) {
                return const TripDetailsPage();
              },
              routes: [
                GoRoute(
                    name: 'tripPlaces',
                    path: 'places',
                    builder: (context, state) {
                      return const TripPlacesScreen();
                    }),
              ]),
          GoRoute(
            name: 'profile',
            path: '/profile',
            builder: (context, state) {
              return ChangeNotifierProvider.value(
                value: context.read<ProfileProvider>(),
                child: const ProfileForm(),
              );
            },
          ),
          GoRoute(
            name: 'login',
            path: '/login',
            builder: (context, state) {
              final authProvider = Provider.of<AuthenticationProvider>(context);
              if (authProvider.isAuthenticated) {
                return const ProfileForm();
              }
              return LoginPage();
            },
          ),
          GoRoute(
            name: 'register',
            path: '/register',
            builder: (context, state) => const RegisterForm(),
          ),
        ])
  ],
);
