import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/config/email_password_validator_config.dart';
import 'package:quiz_game/view/widges_utils/dialog_msg_box_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  final UserController _userController;

  const ResetPasswordPage(@required UserController userController)
      : _userController = userController;

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.hot_pink,
        elevation: 0,
      ),
      body: Container(
        color: ThemeColor.hot_pink,
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: size.height * 0.1,
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
                "FORGET",
                style: TextStyle(
                    fontSize: size.width * 0.1, color: ThemeColor.black),
              ),
            ),
            Center(
              child: Text(
                "PASSWORD",
                style: TextStyle(
                    fontSize: size.width * 0.1, color: ThemeColor.black),
              ),
            ),
            Center(
              child: Container(
                height: size.height * 0.05,
                color: ThemeColor.hot_pink,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) {
                  if (_emailController.text == "")
                    return "The E-mail field is required.";
                  return !InputValidator.isEmailValid(_emailController.text)
                      ? "Incomplete E-mail input."
                      : null;
                },
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: ThemeColor.black, fontSize: size.height * 0.03),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeColor.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeColor.black, width: 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: InkWell(
                onTap: () async {
                  if (_emailController.text == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogMsgBox(
                            "", "The E-mail field is required.");
                      },
                    );
                  } else if (!InputValidator.isEmailValid(
                      _emailController.text)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogMsgBox("", "Incomplete E-mail input.");
                      },
                    );
                  } else {
                    widget._userController.resetAccount(_emailController.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogMsgBox("Reset account",
                            "Password reset link has sent to <${_emailController.text}>");
                      },
                    );
                  }
                },
                child: IgnorePointer(
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: ThemeColor.tiffany_blue,
                      borderRadius: BorderRadius.circular(size.height * 0.05),
                    ),
                    child: Center(
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: size.height * 0.025,
                            color: ThemeColor.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
