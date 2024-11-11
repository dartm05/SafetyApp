class Message {
  String? id;
  final String userId;
  final String message;
  final String? timestamp;
  final bool isUser;

  Message({
    this.id,
    required this.userId,
    required this.message,
    this.timestamp,
    required this.isUser,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      userId: map['userId'],
      message: map['message'],
      timestamp: map['timestamp'],
      isUser: map['isUser'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'timestamp': timestamp,
      'isUser': isUser,
    };
  }
}
