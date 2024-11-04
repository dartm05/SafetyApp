import 'package:flutter/material.dart';
import 'package:menopause_app/core/providers/modal.provider.dart';
import 'package:provider/provider.dart';

import '../models/modal.model.dart';
import '../providers/error_provider.dart';

class ModalWidget extends StatelessWidget {
  final Modal modal;
  final ModalProvider modalProvider;
  final ErrorProvider errorProvider;
  const ModalWidget(
      {super.key,
      required this.modal,
      required this.modalProvider,
      required this.errorProvider});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModalProvider>(
      builder: (context, modalProvider, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
          modalProvider.hideModal();
              },
              child: Container(
          color: Colors.black54,
              ),
            ),
            Center(
              child: AlertDialog(
          title: Text(modal.title),
          content: Text(modal.message),
          actions: [
            TextButton(
              onPressed: () {
                modal.action!();
                modalProvider.hideModal();
              },
              child: Text(modal.actionText),
            ),
          ],
              ),
            ),
          ],
        );
      },
    );
  }
}
