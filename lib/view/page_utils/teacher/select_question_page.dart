import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/quiz_room_controller.dart';
import 'package:quiz_game/models/Question.dart';
import 'package:quiz_game/models/Quiz.dart';
import 'package:uuid/uuid.dart';

import '../../../config/color_config.dart';
import '../../../controllers/question_controller.dart';
import '../../widges_utils/dialog_msg_box_widget.dart';
import '../../widges_utils/dropdown_form_field_widget.dart';

class SelectQuestionPage extends StatefulWidget {
  const SelectQuestionPage(String uid, int numOfQuestions)
      : _uid = uid,
        _numOfQuestions = numOfQuestions;
  final String _uid;
  final int _numOfQuestions;

  @override
  State<SelectQuestionPage> createState() => _SelectQuestionPageState();
}

class _SelectQuestionPageState extends State<SelectQuestionPage> {
  int get _numOfQuestions => widget._numOfQuestions;

  String get _uid => widget._uid;

  QuestionController _questionController = QuestionController();
  QuizRoomController _quizRoomController = QuizRoomController();
  Map<int, Question> questionMap = Map<int, Question>();
  List allQuestionsList = [];
  List dropDownData = [];
  final ScrollController scrollController = ScrollController();

  Future<void> _getAllQuestion() async {
    var list = await _questionController.getAllQuestionsFromDB();
    setState(() {
      allQuestionsList = list;
      for (int i = 0; i < allQuestionsList.length; i++) {
        var tmpData = {
          "display": allQuestionsList[i].questionTitle,
          "value": allQuestionsList[i]
        };
        dropDownData.add(tmpData);
        //print(tmpData);
      }
    });
  }

  Future<void> _submitted() async {

    // quizs.add({
    //   'quizID' : quiz.quizUID,
    //   'teacherID': quiz.teacherUID,
    //   'timestamp': quiz.createdTime,
    //   'numQuestions': quiz.numQuistions,
    //   'studentIDList': quiz.studentList,
    //   'questionIDList': quiz.questionList,
    // });
    var uuid = Uuid();
    var shortUuid = uuid.v4().substring(0, 5);
    var teacherID = _uid;
    var numQuestions = _numOfQuestions;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    List<String> studentIDList = [];
    List<String> questionIDList = questionMap.values.map((value) => value.questionUID.toString()).toList();
    // Quiz(this._quizUID, this._studentList, this._createdTime, this._numQuistions,
    //     this._teacherUID, this._questionList);
    Quiz quiz = Quiz(shortUuid, studentIDList,timestamp,numQuestions,teacherID, questionIDList);
    bool uploadResult = await _quizRoomController.addQuiz(quiz);

    if (uploadResult) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogMsgBox(
                "", "Create Quiz <${shortUuid}> successfully");
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogMsgBox(
                "", "Quiz <${shortUuid}> already exists");
          });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllQuestion();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> containerList = [];

    containerList.add(Center(
      child: Text(
        "Select Questions",
        style: TextStyle(fontSize: size.width * 0.1, color: ThemeColor.black),
      ),
    ));

    containerList.add(Container(
      width: size.width * 0.8,
      child: Divider(height: size.height * 0.05, color: ThemeColor.hot_pink),
    ));

    for (int i = 0; i < _numOfQuestions; i++) {
      containerList.add(
        Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: DropDownFormField(
            titleText: 'Please select question ${i + 1}',
            hintText: 'Please choose one',
            value: questionMap[i + 1],
            onSaved: (value) {
              setState(() {
                questionMap[i + 1] = value;
                //dropDownData.clear();
                print(questionMap);
              });
            },
            onChanged: (value) {
              setState(() {
                questionMap[i + 1] = value;
                //dropDownData.clear();
                print(questionMap);
              });
            },
            dataSource: dropDownData,
            textField: 'display',
            valueField: 'value',
            validator: (_) {
              if (questionMap[i + 1] == null) return "Type can't be empty";
              return "";
            },
          ),
        ),
      );
      containerList.add(Container(
        width: size.width * 0.8,
        child: Divider(
          height: size.height * 0.05,
          color: ThemeColor.hot_pink,
        ),
      ));
    }
    containerList.add(                      Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: InkWell(
        onTap: () {
          if (questionMap.length != _numOfQuestions) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogMsgBox(
                      "", "One or more questions not selected");
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
                "Create Quiz Room",
                style: TextStyle(
                    fontSize: size.height * 0.025,
                    color: ThemeColor.black),
              ),
            ),
          ),
        ),
      ),
    ));

    return Scaffold(
        backgroundColor: ThemeColor.hot_pink,
        appBar: AppBar(
          title: Text('Choose question'),
        ),
        body: Scrollbar(
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
                          children: containerList),
                    ),
                  );
                })));
  }
}
