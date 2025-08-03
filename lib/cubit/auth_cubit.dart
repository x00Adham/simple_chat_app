import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:simple_chat_app/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthService _authService = AuthService();
  //* login with email and password state management
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await _authService.loginWithEmailPassword(email, password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'invalid-credential':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password provided.';
          break;
        default:
          errorMessage = 'An unknown error occurred. (${e.code})';
      }
      emit(AuthFailure(errorMessage));
    }
  }

  //* logout state management
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(Logoutfailure());
    }
  }

  //* Sign up state management
  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      await _authService.signUpWithEmailPassword(email, password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An unknown error occurred. (${e.code})';
      }
      emit(AuthFailure(errorMessage));
    }
  }
}
