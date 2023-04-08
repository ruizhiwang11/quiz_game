part of 'sign_up_bloc.dart';

@immutable
class SignUpState {
   bool isValidEmail;
   bool isValidPassword;
   bool isValidConfirmPassword;
   bool isSuccessful;
   bool isFailed;

  bool get isFormValid => isValidEmail && isValidPassword;

  SignUpState(
      {required this.isValidEmail,
      required this.isValidPassword,
      required this.isSuccessful,
      required this.isFailed,
      required this.isValidConfirmPassword});

  //initial state
  factory SignUpState.empty() {
    return SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: false,
      isSuccessful: false,
      isValidConfirmPassword: false
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: true,
      isSuccessful: false,
      isValidConfirmPassword: true
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isFailed: false,
      isSuccessful: true,
        isValidConfirmPassword: true,
    );
  }

  SignUpState updateEmail(
    bool isEmailValid,
  ) {
      this.isValidEmail = isEmailValid;
      return this;
  }

  SignUpState updatePassword(
      bool isPasswordValid,
      ) {
    this.isValidPassword = isPasswordValid;
    return this;
  }
  SignUpState updateConfirmPassword(bool isConfirmedPassValid){

    this.isValidConfirmPassword = isConfirmedPassValid;
        return this;
  }

}
