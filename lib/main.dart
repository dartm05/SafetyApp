import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menopause_app/src/core/providers/auth_provider.dart';
import 'package:menopause_app/src/features/tripForm/providers/trip_form_provider.dart';
import 'package:menopause_app/src/routes/app_router.dart';
import 'package:provider/provider.dart';

import 'src/core/providers/error_provider.dart';
import 'src/core/providers/modal_provider.dart';
import 'src/core/services/auth_service.dart';
import 'src/core/services/http_service.dart';
import 'src/core/usecases/auth_usecase.dart';
import 'src/features/tripForm/services/trip_service.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ErrorProvider()),
    ChangeNotifierProvider(create: (_) => ModalProvider()),
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(
        authUseCase: AuthUsecase(
          authService: AuthService(
            httpService: HttpService(
                baseUrl:
                    'https://us-central1-tasks-app-b53c1.cloudfunctions.net/api'),
            errorProvider: context.read<ErrorProvider>(),
            modalProvider: context.read<ModalProvider>(),
          ),
        ),
      ),
    ),
    ChangeNotifierProvider(
        create: (context) => TripFormProvider(
                tripService: TripService(
              errorProvider: context.read<ErrorProvider>(),
            ))),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
    );
  }
}
