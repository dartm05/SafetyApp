import 'package:flutter/material.dart';

class DashboardCard {
  final String title;
  final String description;
  IconData? icon;

  DashboardCard({
    required this.title,
    required this.description,
    this.icon,
  });

  factory DashboardCard.fromMap(Map<String, dynamic> map) {
    return DashboardCard(
      title: map['title'],
      description: map['description'],
      icon: map['icon'],
    );
  }
}
