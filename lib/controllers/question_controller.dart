import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/models/Quiz.dart';
import 'package:uuid/uuid.dart';

import '../models/Question.dart';


class QuestionController {
    QuestionController();
    bool add_flag = false;

    void set_flag(bool flag) {
      add_flag = flag;
    }
    Future<bool> addQuestion(Question question) async{

      await FirebaseFirestore.instance
          .collection('questions')
          .where('title', isEqualTo: question.questionTitle)
          .where('first', isEqualTo: question.firstSelection)
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

    Future<List> getAllQuestionsFromDB() async {

      List<Question> allQuestionList = [];
      var res = await FirebaseFirestore.instance
          .collection('questions').get();
      for(int i = 0; i < res.docs.length; i++){
        String uid = res.docs[i].data()['uid'].toString();
        String title = res.docs[i].data()['title'].toString();
        String first = res.docs[i].data()['first'].toString();
        String second = res.docs[i].data()['second'].toString();
        String third = res.docs[i].data()['third'].toString();
        String fourth = res.docs[i].data()['fourth'].toString();
        String answer = res.docs[i].data()['answer'].toString();

        Question tmpQ = Question(uid, title, first, second, third, fourth, answer, DateTime.now().microsecondsSinceEpoch);
        allQuestionList.add(tmpQ);
      }
      return allQuestionList;
    }
}