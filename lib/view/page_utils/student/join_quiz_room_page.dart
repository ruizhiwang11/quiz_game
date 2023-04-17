import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/quiz_room_controller.dart';
import 'package:quiz_game/view/page_utils/student/quiz_page.dart';

import '../../../config/color_config.dart';
import '../../widges_utils/dialog_msg_box_widget.dart';

class JoinQuizRoomPage extends StatefulWidget {
  JoinQuizRoomPage(String uid) : _uid = uid;
  final String _uid;

  @override
  State<JoinQuizRoomPage> createState() => _JoinQuizRoomPageState();
}

class _JoinQuizRoomPageState extends State<JoinQuizRoomPage> {
  String get _uid => widget._uid;
  late String _quizID = "";
  final ScrollController scrollController = ScrollController();
  final TextEditingController _quizTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: ListView.builder(
            controller: scrollController,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: ThemeColor.hot_pink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Join Quiz Room",
                          style: TextStyle(
                              fontSize: size.width * 0.1,
                              color: ThemeColor.black),
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                            height: size.height * 0.05,
                            color: ThemeColor.hot_pink),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: TextFormField(
                          controller: _quizTextController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            if (_quizTextController.text == "")
                              return "The quiz field is required";
                            return "";
                          },
                          decoration: InputDecoration(
                            labelText: "Quiz ID",
                            labelStyle: TextStyle(
                                color: ThemeColor.black,
                                fontSize: size.height * 0.02),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ThemeColor.black, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ThemeColor.black, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Divider(
                          height: size.height * 0.05,
                          color: ThemeColor.hot_pink,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: InkWell(
                          onTap: () async {
                            if (_quizTextController.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The quiz ID is required");
                                  });
                            } else {
                              QuizRoomController controller = QuizRoomController();
                              var result = await controller.checkQuizExist(_quizTextController.text);
                              if(result){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizPage(
                                            _uid, _quizTextController.text)));
                              }
                              else{
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogMsgBox(
                                          "", "The quiz ID not exist in DB");
                                    });
                              }

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
                                  "Join Quiz",
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
            }));
  }
}
