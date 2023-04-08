import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/email_password_validator_config.dart';
import 'package:rxdart/rxdart.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  UserController _userController;

  SignUpBloc({required UserController userController})
      : _userController = userController,
        super(SignUpState.empty()) {
    on<ChangeEmail>(_emailChangeStateEmitter);
    on<ChangePassword>(_passwordChangeStateEmitter);
    on<SignUpWithForm>(_signUpSta1teEmitter);
    on<ConfirmPassword>(_confirmPasswordEmitter);
    on<SignUpEvent>((event, emit) {}, transformer: (events, mapper) {
      return events.debounceTime(const Duration(milliseconds: 300));
    });
  }

  void _confirmPasswordEmitter(ConfirmPassword event, Emitter<SignUpState> emit) async
  {
    bool isTheSame = event.password == event.confirmedPassword;
    print(isTheSame);
    state.updateConfirmPassword(isTheSame);
    emit(state);
  }

  void _emailChangeStateEmitter(
      ChangeEmail event, Emitter<SignUpState> emit) async {
    bool validationResult = InputValidator.isEmailValid(event.email);
    state.updateEmail(validationResult);
    emit(state);
  }

  void _passwordChangeStateEmitter(
      ChangePassword event, Emitter<SignUpState> emit) async {
    bool validationResult = InputValidator.isPasswordValid(event.password);
    state.updatePassword(validationResult);
    emit(state);
  }

  void _signUpSta1teEmitter(SignUpWithForm event, Emitter<SignUpState> emit) async {
    try {
      await _userController.signUpWithEmail(event.email, event.password);
      emit(SignUpState.success());
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
      emit(SignUpState.failure());
    }
  }
}
