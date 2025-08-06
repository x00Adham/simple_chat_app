// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
      'recevierId': receiverId,
      'timestamp': timestamp,
    };
  }
}
