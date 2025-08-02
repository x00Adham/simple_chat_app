import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_chat_app/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {

      await _authService.loginWithEmailPassword(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
