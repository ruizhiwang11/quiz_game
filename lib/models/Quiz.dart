import 'package:equatable/equatable.dart';
import 'package:quiz_game/models/Question.dart';
import 'package:quiz_game/models/Student.dart';

class Quiz {
  String _quizUID;
  List<String> _studentList = [];
  int _createdTime;
  int _numQuistions;

  String _teacherUID;
  List<String> _questionList = [];


  Quiz(String quizUID, String teacherUID, int createdTime, int numQuestions)
      : _quizUID = quizUID,
        _teacherUID = teacherUID,
        _createdTime = createdTime,
        _numQuistions = numQuestions{

  }

  void addQuestion(Question question) {
    _questionList.add(question.questionUID);
  }

  int get numQuistions => _numQuistions;

  set numQuistions(int value) {
    _numQuistions = value;
  }

  void addStudent(Student student) {
    _questionList.add(student.uid);
  }

  List<String> get questionList => _questionList;

  set questionList(List<String> value) {
    _questionList = value;
  }

  String get teacherUID => _teacherUID;

  set teacherUID(String value) {
    _teacherUID = value;
  }

  int get createdTime => _createdTime;

  set createdTime(int value) {
    _createdTime = value;
  }

  List<String> get studentList => _studentList;

  set studentList(List<String> value) {
    _studentList = value;
  }

  String get quizUID => _quizUID;

  set quizUID(String value) {
    _quizUID = value;
  }
}
