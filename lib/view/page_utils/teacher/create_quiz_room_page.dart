import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/question_controller.dart';
import 'package:quiz_game/controllers/quiz_room_controller.dart';

class CreateQuizRoomPage extends StatefulWidget {
  CreateQuizRoomPage(String uid) : _uid = uid;
  final String _uid;
  final QuestionController _questionController = QuestionController();
  final QuizRoomController _quizRoomController = QuizRoomController();

  @override
  State<CreateQuizRoomPage> createState() => _CreateQuizRoomPageState();
}

class _CreateQuizRoomPageState extends State<CreateQuizRoomPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
