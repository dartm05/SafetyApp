class Message {
  String? id;
  final String userId;
  final String message;
  final DateTime timestamp;
  final bool isUser;

  Message({
    this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
    required this.isUser,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      userId: map['userId'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
      isUser: map['isUser'] == 'true',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser ? 'true' : 'false',
    };
  }
}
