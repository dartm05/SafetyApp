import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/auth_provider.dart';
import '../widgets/userForm.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'Register',
                  style: Theme.of(context).textTheme.headline5,
                ),
                  sizedBox,
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
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
                onPressed: () {
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: const Text('Register'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
