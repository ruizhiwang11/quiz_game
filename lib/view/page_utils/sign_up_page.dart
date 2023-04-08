import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/sign_up/sign_up_bloc.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/widges_utils/sign_up_widget.dart';

class SignUpPage extends StatefulWidget {
  final UserController _userController;
  const SignUpPage(@required UserController userController)
      : _userController = userController;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserController get _userController => widget._userController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.hot_pink,
        foregroundColor: ThemeColor.grey,
        elevation: 0,
      ),
      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(
          userController: _userController,
        ),
        child: SignUpWidget(_userController),
      ),
    );
  }
}
