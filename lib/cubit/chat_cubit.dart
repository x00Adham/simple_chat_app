import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:simple_chat_app/models/messages_model.dart';
import 'package:simple_chat_app/services/chat_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription? _messagesSubscription;

  Future<String?> _getUserIdByEmail(String email) async {
    final query = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return query.docs.first.id;
  }

  /// Start listening to messages between the current user and [otherUserId].
  void subscribeToMessages(String otherUserId) {
    final currentUserId = _auth.currentUser?.uid;

    if (currentUserId == null) {
      emit(ChatFailure('User not authenticated'));
      return;
    }

    emit(ChatLoading());

    // Ensure previous subscription is cancelled
    _messagesSubscription?.cancel();

    _messagesSubscription = _chatService
        .getMessages(currentUserId, otherUserId)
        .listen((query) {
      final List<MessageModel> messages = query.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Firestore field fallbacks to handle potential typos/inconsistencies
        final receiverId = (data['recevierId'] ?? data['receiverId'] ?? '') as String;
        final dynamic tsRaw = data['timestamp'] ?? data['timesStamp'];

        return MessageModel(
          message: (data['message'] ?? '') as String,
          senderEmail: (data['senderEmail'] ?? '') as String,
          senderId: (data['senderId'] ?? '') as String,
          receiverId: receiverId,
          timestamp: tsRaw is Timestamp ? tsRaw : Timestamp(0, 0),
        );
      }).toList()
        // Always present messages sorted by timestamp ascending
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

      emit(ChatLoaded(messages));
    }, onError: (error) {
      emit(ChatFailure('Failed to load messages: $error'));
    });
  }

  /// Convenience: subscribe using the receiver's email address.
  Future<void> subscribeToMessagesByEmail(String receiverEmail) async {
    final receiverId = await _getUserIdByEmail(receiverEmail);
    if (receiverId == null) {
      emit(ChatFailure('User not found for email: $receiverEmail'));
      return;
    }
    subscribeToMessages(receiverId);
  }

  /// Send a message from the current user to [receiverId].
  Future<void> sendMessage({required String receiverId, required String message}) async {
    final trimmed = message.trim();
    if (trimmed.isEmpty) return;

    try {
      await _chatService.sendMessage(receiverId, trimmed);
      // No state emission needed; the stream will update ChatLoaded automatically
    } catch (e) {
      emit(ChatFailure('Failed to send message: $e'));
    }
  }

  /// Convenience: send message using the receiver's email address.
  Future<void> sendMessageToEmail({required String receiverEmail, required String message}) async {
    final receiverId = await _getUserIdByEmail(receiverEmail);
    if (receiverId == null) {
      emit(ChatFailure('User not found for email: $receiverEmail'));
      return;
    }
    await sendMessage(receiverId: receiverId, message: message);
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    return super.close();
  }
}