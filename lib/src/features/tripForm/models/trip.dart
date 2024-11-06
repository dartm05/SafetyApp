class Trip {
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String transportation;
  final bool accommodation;
  final bool activities;

  Trip({
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.transportation,
    required this.accommodation,
    required this.activities,
  });
}