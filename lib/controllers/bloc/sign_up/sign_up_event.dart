
part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmail extends SignUpEvent {
  final String email;

  ChangeEmail({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged {email: $email}';
}

class ChangePassword extends SignUpEvent {
  final String password;

  ChangePassword({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged {password: $password}';
}

class Submit extends SignUpEvent {
  final String email;
  final String password;

  Submit({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpWithForm extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithForm({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ConfirmPassword extends SignUpEvent {
  final String password;
  final String confirmedPassword;
  ConfirmPassword({required this.password, required this.confirmedPassword});

  @override
  List<Object> get props => [password, confirmedPassword];
}
