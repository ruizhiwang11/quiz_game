import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/models/Question.dart';
import 'package:uuid/uuid.dart';

import '../models/Quiz.dart';


class QuizRoomController {
  QuizRoomController();
  bool add_flag = false;
  bool exist_flag = false;

  void set_exist_flag(bool flag) {
    exist_flag = flag;
  }

  void set_flag(bool flag) {
    add_flag = flag;
  }
  Future<bool> addQuiz(Quiz quiz) async{

    await FirebaseFirestore.instance
        .collection('quizs')
        .where('quizID', isEqualTo: quiz.quizUID)
        .where('teacherID', isEqualTo: quiz.teacherUID)
        .get()
        .then((users) {
      if (users.size != 0) {
        print("question already exists");
        set_flag(false);
      } else {
        set_flag(true);
      }
    });

    if (!add_flag){
      return false;
    }else{
      CollectionReference quizs =
      FirebaseFirestore.instance.collection('quizs');
      quizs.add({
        'quizID' : quiz.quizUID,
        'teacherID': quiz.teacherUID,
        'timestamp': quiz.createdTime,
        'numQuestions': quiz.numQuistions,
        'studentIDList': quiz.studentList,
        'questionIDList': quiz.questionList,
      });
      set_flag(false);
      return true;
    }
  }

  Future<bool> checkQuizExist(String quizID) async {
    await FirebaseFirestore.instance
        .collection('quizs')
        .where('quizID', isEqualTo: quizID)
        .get().then((users) {
      if (users.size != 0) {
        set_exist_flag(true);
      } else {
        set_exist_flag(false);
      }
    });
    return exist_flag;

    }

  Future<Quiz> getQuizAttributes(String quizID) async {
    var res = await FirebaseFirestore.instance
        .collection('quizs').where('quizID', isEqualTo: quizID).get();
    String qid = res.docs[0].data()['quizID'].toString();
    String teacherID = res.docs[0].data()['teacherID'].toString();
    int timestamp = int.parse(res.docs[0].data()['timestamp'].toString());
    int numQuestions = int.parse(res.docs[0].data()['numQuestions'].toString());
    List<String> studentIDList = List<String>.from(res.docs[0].data()["studentIDList"]);
    List<String> questionIDList = List<String>.from(res.docs[0].data()["questionIDList"]);
    Quiz quiz = Quiz(qid, studentIDList, timestamp, numQuestions, teacherID, questionIDList);
    return quiz;

    }
}