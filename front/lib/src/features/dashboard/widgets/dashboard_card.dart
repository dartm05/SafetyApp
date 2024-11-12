import 'package:flutter/material.dart';
import 'package:safety_app/src/data/models/dashboard_card.dart';

class DashboardCardWidget extends StatelessWidget {
  final DashboardCard card;
  const DashboardCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            card.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(card.description),
        ],
      ),
    );
  }
}
