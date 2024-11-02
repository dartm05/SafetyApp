class Message {
  final String userId;
  final String message;
  final DateTime timestamp;

  Message({
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      userId: map['userId'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}