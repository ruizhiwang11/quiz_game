import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/auth_student/auth_bloc.dart';
import 'package:quiz_game/controllers/question_controller.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/page_utils/dash_board_page.dart';
import 'package:quiz_game/view/page_utils/teacher/create_quiz_room_page.dart';

import '../page_utils/teacher/add_question_page.dart';

class BottomPannelWidgetTeacher extends StatefulWidget {
  const BottomPannelWidgetTeacher(String uid, UserController userController)
      : userID = uid,
        _userController = userController;
  final userID;
  final UserController _userController;

  @override
  _BottomPannelWidgetTeacherState createState() =>
      _BottomPannelWidgetTeacherState();
}

class _BottomPannelWidgetTeacherState extends State<BottomPannelWidgetTeacher> {
  List<Color> iconColorList = [
    ThemeColor.grey,
    ThemeColor.tiffany_blue,
  ];

  @override
  Widget build(BuildContext context) {
    String uid = widget.userID;
    Size size = MediaQuery.of(context).size;
    PageController _myPage = PageController(initialPage: 2);
    QuestionController questionController = QuestionController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColor.hot_pink,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                // Navigator.push(HomePage());
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: ThemeColor.grey,
              ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: ThemeColor.hot_pink,
        child: Container(
          height: size.height * 0.08,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: size.width * 0.1,
                icon: Image.asset(
                  "assets/images/pinder-profile.png",
                  color: iconColorList[0],
                ),
                color: iconColorList[0],
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                    iconColorList = [
                      ThemeColor.grey,
                      ThemeColor.grey,
                    ];
                    iconColorList[0] = ThemeColor.tiffany_blue;
                  });
                },
              ),
              IconButton(
                iconSize: size.width * 0.1,
                icon: Image.asset(
                  "assets/images/pinder-add.png",
                  color: iconColorList[1],
                ),
                color: iconColorList[1],
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _myPage,
        onPageChanged: (number) {
          print('Page Changes to index $number');
          iconColorList = [
            ThemeColor.tan,
            ThemeColor.tan,
          ];
          iconColorList[number] = ThemeColor.tiffany_blue;
        },
        children: <Widget>[
          AddQuestionPage(uid, questionController),
          CreateQuizRoomPage(uid),
        ],
      ),
    );
  }
}
