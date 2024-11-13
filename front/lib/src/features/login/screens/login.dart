import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';
import '../widgets/user_form.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 20);

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: UserForm(
                        widgetList: [
                          sizedBox,
                          TextFormField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          sizedBox,
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                              ),
                              onPressed: () => context.go('/register'),
                              child: const Text('Register'),
                            ),
                          ),
                        ],
                        button: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final isSuccess =
                                  await Provider.of<AuthenticationProvider>(
                                          context,
                                          listen: false)
                                      .signIn(
                                emailController.text.trim(),
                              );
                              if (isSuccess) {
                                emailController.clear();
                                passwordController.clear();
                                context.go('/dashboard');
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
