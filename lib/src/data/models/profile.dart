class Profile {
  final String gender;
  final int age;
  final String ethnicity;
  final bool disability;
  final String preferredModeOfTransport;
  final String dataUsage;
  final bool travelingWithChildren;

  Profile({
    required this.age,
    required this.gender,
    required this.ethnicity,
    required this.disability,
    required this.preferredModeOfTransport,
    required this.dataUsage,
    required this.travelingWithChildren,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      age: json['age'],
      gender: json['gender'],
      ethnicity: json['ethnicity'],
      disability: json['disability'],
      preferredModeOfTransport: json['preferredModeOfTransport'],
      dataUsage: json['dataUsage'],
      travelingWithChildren: json['travelingWithChildren'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'ethnicity': ethnicity,
      'disability': disability,
      'preferredModeOfTransport': preferredModeOfTransport,
      'dataUsage': dataUsage,
      'travelingWithChildren': travelingWithChildren,
    };
  }
}
