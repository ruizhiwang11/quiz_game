import 'package:equatable/equatable.dart';

class Question extends Equatable {
  String questionUID;
  String questionTitle;
  String firstSelection;
  String secondSelection;
  String thirdSelection;
  String fourthSelection;
  String correctAnswer;
  int updatedTime;

  Question(
      this.questionUID,
      this.questionTitle,
      this.firstSelection,
      this.secondSelection,
      this.thirdSelection,
      this.fourthSelection,
      this.correctAnswer,
      this.updatedTime);

  @override
  List<Object?> get props => [
        questionUID,
        questionTitle,
        firstSelection,
        thirdSelection,
        fourthSelection,
        correctAnswer,
        updatedTime
      ];

}
