import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safety_app/src/core/providers/auth_provider.dart';
import 'package:safety_app/src/features/profile/providers/profile_provider.dart';
import 'package:safety_app/src/features/trip_detail/providers/trip_form_provider.dart';
import 'package:safety_app/src/features/trip_detail/usecases/trip_usecases.dart';
import 'package:safety_app/src/features/trip_list/providers/trip_list_provider.dart';
import 'package:safety_app/src/routes/app_router.dart';
import 'package:provider/provider.dart';

import 'src/core/providers/error_provider.dart';
import 'src/core/providers/modal_provider.dart';
import 'src/core/services/auth_service.dart';
import 'src/core/services/http_service.dart';
import 'src/core/usecases/auth_usecase.dart';
import 'src/features/profile/services/profile_service.dart';
import 'src/features/profile/usecases/profile_usecases.dart';
import 'src/features/trip_detail/services/trip_service.dart';
import 'src/features/trip_list/services/trip_list_service.dart';
import 'src/features/trip_list/usecases/trip_list_usecases.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ErrorProvider()),
    ChangeNotifierProvider(create: (_) => ModalProvider()),
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(
        authUseCase: AuthUsecase(
          authService: AuthService(
            httpService: HttpService(baseUrl: dotenv.env['BASE_URL'] ?? ''),
            errorProvider: context.read<ErrorProvider>(),
            modalProvider: context.read<ModalProvider>(),
          ),
        ),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => TripFormProvider(
        tripUseCases: TripUseCases(
          tripService: TripService(
            httpService: HttpService(baseUrl: dotenv.env['BASE_URL'] ?? ''),
            errorProvider: context.read<ErrorProvider>(),
          ),
        ),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => TripListProvider(
        tripListUseCases: TripListUseCases(
          tripListService: TripListService(
            httpService: HttpService(baseUrl: dotenv.env['BASE_URL'] ?? ''),
            errorProvider: context.read<ErrorProvider>(),
          ),
        ),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(
        profileUsecase: ProfileUsecase(
          profileService: ProfileService(
              httpService: HttpService(baseUrl: dotenv.env['BASE_URL'] ?? ''),
              errorProvider: context.read<ErrorProvider>(),
              modalProvider: context.read<ModalProvider>()),
          authenticationProvider: context.read<AuthenticationProvider>(),
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
