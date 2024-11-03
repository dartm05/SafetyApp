import 'package:flutter/material.dart';

import '../models/modal.model.dart';

class ModalWidget extends StatelessWidget {
  final Modal modal;
  const ModalWidget({super.key, required this.modal});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(modal.title),
      content: Text(modal.message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(modal.actionText),
        ),
      ],
    );
  }
}
