import 'package:safety_app/src/core/services/auth_service.dart';
import '../../data/models/user_model.dart';

class AuthUsecase {
  final AuthService authService;

  AuthUsecase({
    required this.authService,
  });

  Future<UserModel?> signIn(String email) async {
    return await authService.signIn(email);
  }

  Future<UserModel?> createUser(String email, String name) async {
    return await authService.createUser(email, name);
  }
}
