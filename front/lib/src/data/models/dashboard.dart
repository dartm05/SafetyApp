import 'package:safety_app/src/data/models/dashboard_card.dart';

class Dashboard {
  Dashboard({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.timestamp,
    required this.cards,
  });

  String? id;
  final String userId;
  final String title;
  final String description;
  final String? timestamp;
  final List<DashboardCard> cards;

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      timestamp: map['timestamp'],
      cards: List<DashboardCard>.from(
          map['cards']?.map((x) => DashboardCard.fromMap(x))),
    );
  }
}
