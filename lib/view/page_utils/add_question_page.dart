import 'package:flutter/material.dart';
import 'package:quiz_game/controllers/question_controller.dart';

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
  final ScrollController scrollController = ScrollController();
  late String _type = "";
  late String _breed = "";
  late String _personality = "";
  late String _interest = "";
  late String _location = "";
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
