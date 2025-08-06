part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<Map<String, dynamic>> users;

  HomeSuccess(this.users);
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure(this.errorMessage);
}
