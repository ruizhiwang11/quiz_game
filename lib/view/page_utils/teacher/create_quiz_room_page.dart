import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/question_controller.dart';
import 'package:quiz_game/controllers/quiz_room_controller.dart';
import 'package:quiz_game/view/page_utils/teacher/select_question_page.dart';

import '../../../config/color_config.dart';
import '../../widges_utils/dialog_msg_box_widget.dart';
import '../../widges_utils/dropdown_form_field_widget.dart';

class CreateQuizRoomPage extends StatefulWidget {
  CreateQuizRoomPage(String uid) : _uid = uid;
  final String _uid;
  final QuestionController _questionController = QuestionController();
  final QuizRoomController _quizRoomController = QuizRoomController();

  @override
  State<CreateQuizRoomPage> createState() => _CreateQuizRoomPageState();
}

class _CreateQuizRoomPageState extends State<CreateQuizRoomPage> {
  String get _uid => widget._uid;
  late String _numOfQuiz = "";
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List data = [
      {"display": "1", "value": "1"},
      {"display": "2", "value": "2"},
      {"display": "3", "value": "3"},
      {"display": "4", "value": "4"},
      {"display": "5", "value": "5"},
    ];
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
                          "Create Quiz Room",
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
                        child: DropDownFormField(
                          titleText: 'How many questions in this quiz room',
                          hintText: 'Please choose one',
                          value: _numOfQuiz,
                          onSaved: (value) {
                            setState(() {
                              _numOfQuiz = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _numOfQuiz = value;
                            });
                          },
                          dataSource: data,
                          textField: 'display',
                          valueField: 'value',
                          validator: (_) {
                            if (_numOfQuiz == "") return "Type can't be empty";
                            return "";
                          },
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
                          onTap: () {
                            if (_numOfQuiz == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The number of quiz is required");
                                  });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectQuestionPage(
                                          _uid, int.parse(_numOfQuiz))));
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
                                  "To Select question",
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
