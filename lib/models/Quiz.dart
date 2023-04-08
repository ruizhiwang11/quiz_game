import 'package:equatable/equatable.dart';
import 'package:quiz_game/models/Question.dart';

class Quiz {
  String _quizUID;
  List<String> _studentList = [];
  DateTime _createdTime;

  String _teacherUID;
  List<Question> _questionList = [];


  Quiz(String quizUID, String teacherUID, DateTime createdTime)
      : _quizUID = quizUID,
        _teacherUID = teacherUID,
        _createdTime = createdTime{

  }

  void addQuestion(Question question) {
    _questionList.add(question);
  }


}
