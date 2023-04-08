import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/email_password_validator_config.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserController _userController;
  LoginBloc(@required UserController userController)
      : _userController = userController,
        super(LoginState.empty()) {
    on<ChangeEmail>(_emailChangeStateEmitter);
    on<ChangePassword>(_passwordChangeStateEmitter);
    on<Login>(_loginStateEmitter);
    on<LoginEvent>((event, emit) {}, transformer: (events, mapper) {
      return events.debounceTime(const Duration(milliseconds: 300));
    });
  }

  void _emailChangeStateEmitter(
      ChangeEmail event, Emitter<LoginState> emit) async {
    bool validationResult = InputValidator.isEmailValid(event.email);
    state.updateEmail(validationResult);
    emit(state);
  }

  void _passwordChangeStateEmitter(
      ChangePassword event, Emitter<LoginState> emit) async {
    bool validationResult = InputValidator.isPasswordValid(event.password);
    state.updatePassword(validationResult);
    emit(state);
  }

  void _loginStateEmitter(Login event, Emitter<LoginState> emit) async {
    try {
      await _userController.signInWithEmail(event.email, event.password);
      emit(LoginState.success());
    } catch (e, s) {
      print("Exception $e");
      print("StackTrace $s");
      emit(LoginState.failure());
    }
  }
}
