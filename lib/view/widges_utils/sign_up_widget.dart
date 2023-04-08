import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/auth_student/auth_bloc.dart';
import 'package:quiz_game/controllers/bloc/sign_up/sign_up_bloc.dart';
import 'package:quiz_game/controllers/student_controller.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/models/Student.dart';
import 'package:quiz_game/models/Teacher.dart';

import 'package:quiz_game/view/widges_utils/dropdown_form_field_widget.dart';

import '../../controllers/teacher_controller.dart';
import 'dialog_msg_box_widget.dart';

class SignUpWidget extends StatefulWidget {
  final UserController _userController;

  const SignUpWidget(@required UserController userController)
      : _userController = userController;

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late String _entity = "";
  late SignUpBloc _signUpBloc;
  UserController get _userController => widget._userController;

  void _onEmailChanged() {
    _signUpBloc.add(
      ChangeEmail(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      ChangePassword(password: _passwordController.text),
    );
  }

  void _onConfirmEmailChanged() {
    _signUpBloc.add(
      ConfirmPassword(
          password: _passwordController.text,
          confirmedPassword: _confirmPasswordController.text),
    );
  }

  void _onFormSubmitted() {
    _signUpBloc.add(
      SignUpWithForm(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmEmailChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) async {
        if (state.isFailed) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogMsgBox("", "Email account has existed");
              });
        }
        if (state.isSuccessful) {
          print("Success");
          if (_entity == "Student"){

            BlocProvider.of<AuthBloc>(context).add(LoggedInStudent());

            String uid = await _userController.getUser();
            String email = _emailController.text;
            Student student = Student(uid, email);
            StudentController studentController = StudentController();
            studentController.addStudent(student);
            // create student db
          }
          else {
            BlocProvider.of<AuthBloc>(context).add(LoggedInTeacher());
            String uid = await _userController.getUser();
            String email = _emailController.text;
            Teacher teacher = Teacher(uid, email);
            TeacherController teacherController = TeacherController();
            teacherController.addTeacher(teacher);
            // create teacher db
          }

          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: size.width * 0.1, color: ThemeColor.black),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.05,
                      color: ThemeColor.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) {
                        if (_emailController.text == "")
                          return "The Email field is required";
                        return !state.isValidEmail ? "Invalid Email." : null;
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
                      // maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.multiline,
                      validator: (_) {
                        if (_passwordController.text == "")
                          return "The Password field is required.";
                        return !state.isValidPassword
                            ? "The input password does not meet the minimum security requirement. Your password needs to include both upper and lower case,with at least one number and at least 8 characters long."
                            : null;
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
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      autocorrect: false,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) {
                        if (_confirmPasswordController.text == "")
                          return "Confirm Password is required";
                        return !state.isValidConfirmPassword
                            ? "Password does not match"
                            : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
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
                          // _breed = "";
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _entity = value;
                          // _breed = "";
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
                                return DialogMsgBox("",
                                    "Incomplete E-mail input or the email is invalid");
                              });
                        } else if (_passwordController.text == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox(
                                    "", "The Password field is required.");
                              });
                        } else if (!state.isValidPassword) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox("",
                                    "The input password does not meet the minimum security requirement. Your password needs to include both upper and lower case, with at least one number and at least 8 characters long.");
                              });
                        } else if (!state.isValidConfirmPassword) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogMsgBox("",
                                    "The confirm password should be the same as password");
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
                            "Sign Up",
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: ThemeColor.black),
                          ),
                        ),
                      )),
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
