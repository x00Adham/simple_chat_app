class MessageModel {
  final String id;
  final String text;
  final String senderId;
  final String senderEmail;
  final DateTime timestamp;
  final String chatRoomId;

  MessageModel({
    required this.id,
    required this.text,
    required this.senderId,
    required this.senderEmail,
    required this.timestamp,
    required this.chatRoomId,
  });

  // Convert Message to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'senderId': senderId,
      'senderName': senderEmail,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'chatRoomId': chatRoomId,
    };
  }

  // Create Message from Firebase Map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      senderEmail: map['senderName'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      chatRoomId: map['chatRoomId'] ?? '',
    );
  }
}