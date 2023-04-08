part of 'login_bloc.dart';

@immutable
class LoginState {
   bool isValidEmail;
   bool isValidPassword;
   bool isSuccessful;
   bool isFailed;


  LoginState(
      {required this.isValidEmail,
      required this.isValidPassword,
      required this.isSuccessful,
      required this.isFailed});

  //initial state
  factory LoginState.empty() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: false,
      isSuccessful: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: false,
      isSuccessful: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: true,
      isSuccessful: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: false,
      isSuccessful: true,
    );
  }

  LoginState updateEmail(bool isEmailValid)
  {
    this.isValidEmail = isEmailValid;
    return this;
  }

  LoginState updatePassword(bool isPasswordValid) {
      this.isValidPassword = isPasswordValid;
      return this;
  }

}
