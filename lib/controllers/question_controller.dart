import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/models/Question.dart';
import 'package:uuid/uuid.dart';


class QuestionController {
    QuestionController();
    bool add_flag = false;

    void set_flag(bool flag) {
      add_flag = flag;
    }
    Future<bool> addQuestion(Question question) async{

      await FirebaseFirestore.instance
          .collection('questions')
          .where('uid', isEqualTo: question.questionUID)
          .where('title', isEqualTo: question.questionTitle)
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
        CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');
        questions.add({
          'uid' : question.questionUID,
          'title': question.questionTitle,
          'first': question.firstSelection,
          'second': question.secondSelection,
          'third': question.thirdSelection,
          'fourth': question.fourthSelection,
          'answer': question.correctAnswer,
        });
        set_flag(false);
        return true;


      }
    }
}