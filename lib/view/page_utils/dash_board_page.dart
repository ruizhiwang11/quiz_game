import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/login/login_bloc.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/widges_utils/login_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColor.hot_pink,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.hot_pink,
        elevation: 0,
        foregroundColor: ThemeColor.grey,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: size.height * 0.15,
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
              padding: EdgeInsets.all(size.height * 0.02),
              height: size.height * 0.1,
              width: size.width,
              color: ThemeColor.hot_pink,
              child: Text(
                "Home",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.05,
            color: ThemeColor.hot_pink,
            child: Text('Daily Active Use:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.all(size.height * 0.2),
            width: size.width * 0.8,
            height: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ThemeColor.white,
              image: DecorationImage(
                image: AssetImage("assets/images/active_user.png"),
                scale: 2,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}

