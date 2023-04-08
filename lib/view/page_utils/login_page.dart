import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/login/login_bloc.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/widges_utils/login_widget.dart';

class LoginPage extends StatefulWidget {
  final UserController _userController;
  const LoginPage(@required UserController userController)
      : _userController = userController;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController get _userController => widget._userController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.hot_pink,
        elevation: 0,
        foregroundColor: ThemeColor.grey,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(_userController),
        child: LoginWidget(_userController),
      ),
    );
  }
}
