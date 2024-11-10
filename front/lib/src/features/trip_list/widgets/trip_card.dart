import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safety_app/src/data/models/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final Function() onUpdate;
  const TripCard({super.key, required this.trip, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip to ${trip.destination.split(",").first.split(" ").take(2).join(" ")}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              trip.destination,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('MMMM dd, yyyy').format(trip.startDate),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
