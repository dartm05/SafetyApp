import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menopause_app/core/providers/auth_provider.dart';
import 'package:menopause_app/routes/app-router.dart';
import 'package:provider/provider.dart';
import 'core/providers/error_provider.dart';
import 'core/providers/modal.provider.dart';
import 'core/services/http.service.dart';
import 'core/usecases/auth_usecase.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ErrorProvider()),
    ChangeNotifierProvider(create: (_) => ModalProvider()),
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(
        authUseCase: AuthUsecase(
          httpService: HttpService(baseUrl: 'https://us-central1-tasks-app-b53c1.cloudfunctions.net/api'),
          errorProvider: context.read<ErrorProvider>(),
          modalProvider: context.read<ModalProvider>(),
        ),
      ),
    ),
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
