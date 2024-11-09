class Trip {
  String? id;
  String? name;
  DateTime? createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final String origin;
  final String destination;
  final String transportation;
  final String hotel;
  final String travelStyle;
  final bool ladiesOnlyMetro;
  final bool ladiesOnlyTaxi;
  final bool loudNoiseSensitive;
  final bool crowdFear;
  final bool noIsolatedPlaces;
  final bool lowCrime;
  final bool publicTransportOnly;
  final List<String> placesToVisit;

  Trip({
    required this.origin,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.transportation,
    this.hotel = '',
    this.travelStyle = '',
    this.ladiesOnlyMetro = false,
    this.ladiesOnlyTaxi = false,
    this.loudNoiseSensitive = false,
    this.crowdFear = false,
    this.noIsolatedPlaces = false,
    this.lowCrime = false,
    this.publicTransportOnly = false,
    this.placesToVisit = const [],
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      origin: json['origin'],
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      transportation: json['transportation'],
      hotel: json['hotel'],
      travelStyle: json['travelStyle'],
      ladiesOnlyMetro: json['ladiesOnlyMetro'],
      ladiesOnlyTaxi: json['ladiesOnlyTaxi'],
      loudNoiseSensitive: json['loudNoiseSensitive'],
      crowdFear: json['crowdFear'],
      noIsolatedPlaces: json['noIsolatedPlaces'],
      lowCrime: json['lowCrime'],
      publicTransportOnly: json['publicTransportOnly'],
      placesToVisit: List<String>.from(json['placesToVisit']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'transportation': transportation,
      'hotel': hotel,
      'travelStyle': travelStyle,
      'ladiesOnlyMetro': ladiesOnlyMetro,
      'ladiesOnlyTaxi': ladiesOnlyTaxi,
      'loudNoiseSensitive': loudNoiseSensitive,
      'crowdFear': crowdFear,
      'noIsolatedPlaces': noIsolatedPlaces,
      'lowCrime': lowCrime,
      'publicTransportOnly': publicTransportOnly,
      'placesToVisit': placesToVisit,
    };
  }
}
