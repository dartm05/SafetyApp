import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menopause_app/core/services/auth_provider.dart';
import 'package:menopause_app/features/login/widgets/userForm.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 20);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: UserForm(
              widgetList: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline5,
                ),
                sizedBox,
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                sizedBox,
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ],
              button: ElevatedButton(
                onPressed: () async {
                  final isSuccess = await Provider.of<AuthenticationProvider>(
                          context,
                          listen: false)
                      .signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (isSuccess) {
                    emailController.clear();
                    passwordController.clear();
                    context.go('/chat');
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
