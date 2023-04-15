import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/models/Question.dart';
import 'package:uuid/uuid.dart';

import '../models/Quiz.dart';


class QuizRoomController {
  QuizRoomController();
  bool add_flag = false;

  void set_flag(bool flag) {
    add_flag = flag;
  }
  Future<bool> addQuiz(Quiz quiz) async{

    await FirebaseFirestore.instance
        .collection('questions')
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
}