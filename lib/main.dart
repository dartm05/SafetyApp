import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menopause_app/core/services/auth_provider.dart';
import 'package:menopause_app/routes/app-router.dart';
import 'package:provider/provider.dart';

import 'core/services/modal.provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ModalProvider(),
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
