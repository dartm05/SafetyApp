import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';

class UserForm extends StatefulWidget {
  final List<Widget> widgetList;
  final ElevatedButton button;
  const UserForm({super.key, required this.widgetList, required this.button});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 20);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.height - 500,
      constraints: const BoxConstraints(
          maxWidth: 600, minWidth: 400, minHeight: 400, maxHeight: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: !authProvider.isLoading
            ? Column(
                children: [
                  sizedBox,
                  ...widget.widgetList,
                  sizedBox,
                  sizedBox,
                  sizedBox,
                  widget.button,
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
