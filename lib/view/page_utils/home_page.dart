import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/controllers/bloc/auth_student/auth_bloc.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:quiz_game/config/color_config.dart';
import 'package:quiz_game/view/widges_utils/home_widget.dart';
import 'package:quiz_game/view/widges_utils/bottom_pannel_widget.dart';

import '../widges_utils/bottom_pannel_widget_teacher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController _userController = UserController();
  late AuthBloc _authBloc;
  bool add_flag = false;

  void set_flag(bool flag) {
    add_flag = flag;
  }

  // Future<void> linkdb() async {
  //   String tmpuid = "";
  //   _userController.getUser().then((uid) async {
  //     await FirebaseFirestore.instance
  //         .collection('owner')
  //         .where('uid', isEqualTo: uid)
  //         .get()
  //         .then((owner) {
  //       if (owner.size != 0) {
  //         print("owner already exists");
  //         set_flag(false);
  //       } else {
  //         tmpuid = uid;
  //         set_flag(true);
  //       }
  //     });
  //   });
  //   if (add_flag) {
  //     await _userController.getEmail().then((email) {
  //       CollectionReference like =
  //           FirebaseFirestore.instance.collection('owner');
  //       like
  //           .add({'uid': tmpuid, 'email': email})
  //           .then((value) => print("owner Added"))
  //           .catchError((error) => print("Failed to add owner: $error"));
  //       set_flag(false);
  //     });
  //   }
  // }

  @override
  void initState() {
    _authBloc = AuthBloc(_userController);
    _authBloc.add(AppStarted());

    // linkdb();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: MaterialApp(
          themeMode: ThemeMode.dark,
          color: HexColor('#FFAEBC'),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder(
            bloc: _authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state is UnAuth) {
                return HomeWidget(_userController);
              } else if (state is AuthStudent) {
                // @TODO add check for the user for student and teacher and return different page
                return BottomPannelWidget(
                    state.UID, _userController);
              } else if (state is AuthTeacher){
                return BottomPannelWidgetTeacher(
                    state.UID, _userController);
              }
              else {
                return Container();
              }
            },
          )),
    );
  }
}
