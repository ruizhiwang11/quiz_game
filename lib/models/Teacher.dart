import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  String uid;
  String email;


  Teacher(this.uid, this.email);



  @override
  List<Object?> get props => [uid, email];

}

