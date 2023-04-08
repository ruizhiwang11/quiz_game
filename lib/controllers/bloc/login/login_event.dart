part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmail extends LoginEvent {
  final String email;

  ChangeEmail({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged {email: $email}';
}

class ChangePassword extends LoginEvent {
  final String password;

  ChangePassword({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged {password: $password}';
}

class Submit extends LoginEvent {
  final String email;
  final String password;

  Submit({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
