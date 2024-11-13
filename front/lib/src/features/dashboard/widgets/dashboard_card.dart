import 'package:flutter/material.dart';
import 'package:safety_app/src/data/models/dashboard_card.dart';

class DashboardCardWidget extends StatelessWidget {
  final DashboardCard card;
  const DashboardCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Text(card.description),
          ),
          SizedBox(height: 10),
          Container(color: Theme.of(context).primaryColor, height: 5),
        ],
      ),
    );
  }
}
