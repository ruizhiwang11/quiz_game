part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent{}

class LoggedInStudent extends AuthEvent{}

class LoggedInTeacher extends AuthEvent{}

class LoggedOut extends AuthEvent{}

