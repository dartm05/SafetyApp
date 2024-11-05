class Response {
  final String message;
  final bool success;

  Response({
    required this.message,
    required this.success,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      message: json['message'],
      success: json['success'],
    );
  }
}
