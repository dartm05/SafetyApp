import 'package:menopause_app/src/core/services/auth_service.dart';
import '../models/user_model.dart';

class AuthUsecase {
  final AuthService authService;

  AuthUsecase({
    required this.authService,
  });

  Future<UserModel?> signIn(String email, String password) async {
    return await authService.signIn(email, password);
  }

  Future<void> createUser(String email, String password, String name) async {
    return await authService.createUser(email, password, name);
  }
}
