import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/auth_student/auth_bloc.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/page_utils/dash_board_page.dart';

class BottomPannelWidget extends StatefulWidget {
  const BottomPannelWidget(
      String uid, UserController userController)
      : userID = uid,
        _userController = userController;
  final userID;
  final UserController _userController;

  @override
  _BottomPannelWidgetState createState() => _BottomPannelWidgetState();
}

class _BottomPannelWidgetState extends State<BottomPannelWidget> {
  List<Color> iconColorList = [
    ThemeColor.grey,
    ThemeColor.grey,
    ThemeColor.tiffany_blue,
    ThemeColor.grey,
    ThemeColor.grey
  ];

  @override
  Widget build(BuildContext context) {
    String uid = widget.userID;
    Size size = MediaQuery.of(context).size;
    PageController _myPage = PageController(initialPage: 2);
    var page_one_icon = IconButton(
      iconSize: size.width * 0.1,
      icon: Image.asset("assets/images/pinder-profile.png", color: iconColorList[0],),
      color: iconColorList[0],
      onPressed: () {
        setState(() {
          _myPage.jumpToPage(0);
          iconColorList = [
            ThemeColor.grey,
            ThemeColor.grey,
            ThemeColor.grey,
            ThemeColor.grey,
            ThemeColor.grey
          ];
          iconColorList[0] = ThemeColor.tiffany_blue;
        });
      },
    );
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
              page_one_icon,
              IconButton(
                iconSize: size.width * 0.1,
                icon: Image.asset("assets/images/pinder-add.png", color: iconColorList[1],),
                color: iconColorList[1],
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: size.width * 0.1,
                icon: Image.asset("assets/images/pinder-home.png", color: iconColorList[2],),
                color: iconColorList[2],
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: size.width * 0.1,
                icon: Image.asset("assets/images/pinder-match.png", color: iconColorList[3],),
                color: iconColorList[3],
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
                  });
                },
              ),
              IconButton(
                iconSize: size.width * 0.1,
                icon: Image.asset("assets/images/pinder-chat.png", color: iconColorList[4],),
                color: iconColorList[4],
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(4);
                  });
                },
              )
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
            ThemeColor.grey,
            ThemeColor.grey,
            ThemeColor.grey,
            ThemeColor.grey,
            ThemeColor.grey
          ];
          iconColorList[number] = ThemeColor.tiffany_blue;
        },
        children: <Widget>[
          // PetProfilePage(),
          // AddPetPage(),
          DashBoardPage(),
           //MatchPage(),
          // ChattingPage(),
        ],
      ),
    );
  }
}
