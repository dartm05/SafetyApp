class Error {
  final String message;
  final String title;
  final String status;
  final int statusCode;

  Error({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.title,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      title: json['title'],
    );
  }
}
