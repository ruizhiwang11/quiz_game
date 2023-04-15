import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/question_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../config/color_config.dart';
import '../../../models/Question.dart';
import '../../widges_utils/dialog_msg_box_widget.dart';
import '../../widges_utils/dropdown_form_field_widget.dart';


class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage(String uid, QuestionController questionController) : _uid = uid, _questionController = questionController;
  final String _uid;
  final QuestionController _questionController;

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {

  final TextEditingController _questionTitleController = TextEditingController();
  final TextEditingController _firstSelectionController = TextEditingController();
  final TextEditingController _secondSelectionController = TextEditingController();
  final TextEditingController _thirdSelectionController = TextEditingController();
  final TextEditingController _fourthSelectionController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  QuestionController get _questionController => widget._questionController;
  late String _title = "";
  late String _first = "";
  late String _second = "";
  late String _third = "";
  late String _fourth = "";
  late String _correct = "";

  Future<void> _submitted() async {
    var uuid = Uuid();
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    _title = _questionTitleController.text;
    _first = _firstSelectionController.text;
    _second = _secondSelectionController.text;
    _third = _thirdSelectionController.text;
    _fourth = _fourthSelectionController.text;
    String uuid_str = uuid.toString();
    Question question = Question(uuid.v1(), _title,_first,_second,_third, _fourth, _correct, timestamp);
    bool uploadResult = await _questionController.addQuestion(question);

    if (uploadResult) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogMsgBox(
                "", "Create Quiz <${_title}> successfully");
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogMsgBox(
                "", "Quiz <${_title}> already exists");
          });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List data = [
      {
        "display": "A",
        "value": "A"
      },
      {
        "display": "B",
        "value": "B"
      },
      {
        "display": "C",
        "value": "C"
      },
      {
        "display": "D",
        "value": "D"
      },
    ];
    return Scrollbar(
        isAlwaysShown: true,
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
                          "Add Question",
                          style: TextStyle(
                              fontSize: size.width * 0.1,
                              color: ThemeColor.black),
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
                          controller: _questionTitleController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            if (_questionTitleController.text == "")
                              return "The title field is required";
                            return "";
                          },
                          decoration: InputDecoration(
                            labelText: "Quiz Title",
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
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: TextFormField(
                          controller: _firstSelectionController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            if (_firstSelectionController.text == "")
                              return "The first selection field is required";
                            return "";
                          },
                          decoration: InputDecoration(
                            labelText: "First Selection",
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
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: TextFormField(
                          controller: _secondSelectionController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            if (_secondSelectionController.text == "")
                              return "The second selection field is required";
                            return "";
                          },
                          decoration: InputDecoration(
                            labelText: "Second Selection",
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
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: TextFormField(
                          controller: _thirdSelectionController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            if (_thirdSelectionController.text == "")
                              return "The third selection field is required";
                            return "";
                          },
                          decoration: InputDecoration(
                            labelText: "Third Selection",
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
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: TextFormField(
                          controller: _fourthSelectionController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (_) {
                            if (_fourthSelectionController.text == "")
                              return "The fourth selection field is required";
                            return "";
                          },
                          decoration: InputDecoration(
                            labelText: "Fourth Selection",
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
                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: DropDownFormField(
                          titleText: 'Correct answer',
                          hintText: 'Please choose one',
                          value: _correct,
                          onSaved: (value) {
                            setState(() {
                              _correct = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _correct = value;
                            });
                          },
                          dataSource: data,
                          textField: 'display',
                          valueField: 'value',
                          validator: (_) {
                            if (_correct == "") return "Type can't be empty";
                            return "";
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: InkWell(
                          onTap: () {
                            if (_questionTitleController.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The title Name is required.");
                                  });
                            } else if (_firstSelectionController.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The first selection is required.");
                                  });
                            } else if (_secondSelectionController.text == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The second selection is required.");
                                  });
                            } else if (_thirdSelectionController.text  == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The third selection is required.");
                                  });
                            } else if (_fourthSelectionController == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The fourth selection is required.");
                                  });
                            } else if (_correct == "") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogMsgBox(
                                        "", "The Matchup Interest is required.");
                                  });
                            } else {
                              _submitted();
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
                                  "Submit",
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
