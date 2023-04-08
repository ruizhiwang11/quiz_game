import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/page_utils/sign_up_page.dart';
import 'package:quiz_game/view/page_utils/login_page.dart';

class HomeWidget extends StatefulWidget {
  final UserController _userController;
  const HomeWidget(@required UserController userController)
      : _userController = userController;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  UserController get _userController => widget._userController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: ThemeColor.hot_pink,
      width: size.width,
      height: size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: size.height * 0.3,
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
              child: Container(
                height: size.height * 0.3,
                color: ThemeColor.hot_pink,
              ),
            ),
            Center(
              child: ElevatedButton(
                child:
                    Text("Login".toUpperCase(), style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.6, size.height * 0.01)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(ThemeColor.black),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColor.tiffany_blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                            side: BorderSide(color: ThemeColor.tiffany_blue)))),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(_userController))),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                child: Text("Get an account".toUpperCase(),
                    style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.6, size.height * 0.01)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(ThemeColor.black),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColor.tiffany_blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                            side: BorderSide(color: ThemeColor.tiffany_blue)))),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage(_userController))),
              ),
            ),
          ]),
    );
  }
}
