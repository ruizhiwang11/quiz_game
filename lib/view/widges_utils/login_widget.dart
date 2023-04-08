import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/auth_student/auth_bloc.dart';
import 'package:quiz_game/controllers/bloc/login/login_bloc.dart';
import 'package:quiz_game/controllers/student_controller.dart';
import 'package:quiz_game/controllers/teacher_controller.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/view/page_utils/reset_password_page.dart';
import 'package:quiz_game/view/page_utils/sign_up_page.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialog_msg_box_widget.dart';
import 'dropdown_form_field_widget.dart';

class LoginWidget extends StatefulWidget {
  final UserController _userController;

  const LoginWidget(@required UserController userController)
      : _userController = userController;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserController get _userController => widget._userController;
  late LoginBloc _loginBloc;
  late String _entity = "";

  void _onEmailChanged() {
    _loginBloc.add(
      ChangeEmail(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      ChangePassword(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      Login(email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) async {
        if (state.isFailed) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogMsgBox(
                    "Unmatched email and password", "Invalid E-mail/Password.");
              });
        }
        if (state.isSuccessful) {
          // @TODO check entity here, and return different AuthState
          print("Success");
          if (_entity == "Student") {
            StudentController studentController = StudentController();
            bool valid_student = await studentController
                .checkStudentFromEmail(_emailController.text);
            if (!valid_student) {
              print("Not a valid student");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogMsgBox("Invalid entity selected",
                        "Please select correct entity");
                  });
              sleep(Duration(seconds: 2));
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            } else {
              BlocProvider.of<AuthBloc>(context).add(LoggedInStudent());
              Navigator.of(context).pop();
            }

          } else {
            TeacherController teacherController = TeacherController();
            bool valid_teacher = await teacherController
                .checkTeacherFromEmail(_emailController.text);
            if (!valid_teacher) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogMsgBox("Invalid entity selected",
                        "Please select correct entity");
                  });
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            } else {
              BlocProvider.of<AuthBloc>(context).add(LoggedInTeacher());
              Navigator.of(context).pop();
            }

            // create teacher db
          }

        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: ThemeColor.hot_pink,
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: size.width * 0.3,
                      width: size.width,
                      color: ThemeColor.hot_pink,
                      child: Image.asset(
                        "assets/images/study.png",
                        fit: BoxFit.fitHeight,
                        scale: 2,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: size.width * 0.1, color: ThemeColor.black),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.05,
                      color: ThemeColor.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) {
                        if (_emailController.text == "")
                          return "The email field is required";
                        return !state.isValidEmail
                            ? "Incomplete Email input"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: ThemeColor.black,
                            fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColor.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColor.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) {
                        if (_passwordController.text == "")
                          return "The password field is required";
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: ThemeColor.black,
                            fontSize: size.height * 0.03),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColor.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColor.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: DropDownFormField(
                      titleText: 'Entity group',
                      hintText: 'Please choose one',
                      value: _entity,
                      onSaved: (value) {
                        setState(() {
                          _entity = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _entity = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Student",
                          "value": "Student",
                        },
                        {
                          "display": "Teacher",
                          "value": "Teacher",
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                      validator: (_) {
                        if (_entity == "") return "Type can't be empty";
                        return "";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: InkWell(
                      onTap: () {
                        if (_emailController.text == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox(
                                    "", "The E-mail field is required.");
                              });
                        } else if (!state.isValidEmail) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox(
                                    "", "Incomplete E-mail input.");
                              });
                        } else if (_passwordController.text == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox(
                                    "", "The Password field is required.");
                              });
                        } else if (_entity == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox(
                                    "", "The Entity is required.");
                              });
                        } else {
                          _onFormSubmitted();
                        }
                      },
                      child: IgnorePointer(
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: ThemeColor.tiffany_blue,
                            borderRadius:
                                BorderRadius.circular(size.height * 0.05),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: size.height * 0.025,
                                  color: ThemeColor.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ResetPasswordPage(_userController);
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Forget password",
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          color: ThemeColor.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await launch(
                          "mailto:quizhelp@gmail.com?subject=Need help from Admin"))
                        throw 'Could not open email app';
                    },
                    child: Text(
                      "Need help?",
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          color: ThemeColor.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
