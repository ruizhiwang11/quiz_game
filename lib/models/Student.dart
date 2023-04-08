import 'package:equatable/equatable.dart';

class Student extends Equatable {
  String uid;
  String email;


  Student(this.uid, this.email);



  @override
  List<Object?> get props => [uid, email];

}
