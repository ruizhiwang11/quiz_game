import 'package:flutter/material.dart';

import '../../../config/color_config.dart';

class QuizPage extends StatefulWidget {
  QuizPage(String uid, String quizID)
      : _uid = uid,
        _quizID = quizID;
  final String _uid;
  final String _quizID;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> questions = [
    'Question 1?',
    'Question 2?',
    'Question 3?',
    'Question 4?',
    'Question 5?',
  ];

  List<List<String>> options = [
    ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  ];

  List<int> correctAnswers = [
    0,
    1,
    2,
    1,
    3
  ]; // Replace with your correct answers

  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;

  void submitQuiz() {
    setState(() {
      quizCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        centerTitle: true,
      ),
      backgroundColor: ThemeColor.hot_pink,
      body: quizCompleted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz Completed!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your score is $score / ${questions.length}',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        quizCompleted = false;
                        score = 0;
                        currentQuestionIndex = 0;
                      });
                    },
                    child: Text('Restart Quiz'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Exit'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      questions[currentQuestionIndex],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ...options[currentQuestionIndex]
                        .asMap()
                        .entries
                        .map((option) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            if (correctAnswers[currentQuestionIndex] ==
                                option.key) {
                              score++;
                            }

                            if (currentQuestionIndex < questions.length - 1) {
                              setState(() {
                                currentQuestionIndex++;
                              });
                            } else {
                              submitQuiz();
                            }
                          },
                          child: Text(option.value),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (currentQuestionIndex > 0) {
                                currentQuestionIndex--;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                          color: currentQuestionIndex > 0
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (currentQuestionIndex < questions.length - 1) {
                                currentQuestionIndex++;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: currentQuestionIndex < questions.length - 1
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
