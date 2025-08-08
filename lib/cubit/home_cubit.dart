import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:simple_chat_app/services/chat_service.dart';
import 'package:simple_chat_app/services/auth_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //* Get users stream and manage state
  void getUserStream() {
    emit(HomeLoading());
    try {
      _chatService.getUserStream().listen(
        (users) {
          emit(HomeSuccess(users));
        },
        onError: (error) {
          log('Error fetching users: $error');
          emit(HomeFailure('Failed to load users: $error'));
        },
      );
    } catch (e) {
      log('Error in getUserStream: $e');
      emit(HomeFailure('Failed to load users: $e'));
    }
  }

  //* Get current user email
  String? getCurrentUserEmail() {
    return _authService.getCurrentuser()?.email;
  }

  //* Check if user is current user
  bool isCurrentUser(String email) {
    final currentUserEmail = getCurrentUserEmail();
    return currentUserEmail == email;
  }

  //* Refresh users
  Future<void> refreshUsers() async {
    emit(HomeLoading());
    try {
      getUserStream();
    } catch (e) {
      log('Error refreshing users: $e');
      emit(HomeFailure('Failed to refresh users: $e'));
    }
  }
}
