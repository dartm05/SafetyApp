import 'package:flutter/material.dart';

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
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            sizedBox,
            ...widget.widgetList,
            sizedBox,
            sizedBox,
            sizedBox,
            widget.button,
          ],
        ),
      ),
    );
  }
}
