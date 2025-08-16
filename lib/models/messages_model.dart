// ignore_for_file: public_member_api_docs, sort_constructors_firs
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderEmail;
  final String senderId;
  final String receiverId;
  final Timestamp timestamp;
  MessageModel({
    required this.message,
    required this.senderEmail,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'senderEmail': senderEmail,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      senderEmail: map['senderEmail'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      timestamp:
          map['timestamp'] is Timestamp
              ? map['timestamp']
              : Timestamp.fromMillisecondsSinceEpoch(
                (map['timestamp'] ?? 0) is int ? map['timestamp'] : 0,
              ),
    );
  }
}
