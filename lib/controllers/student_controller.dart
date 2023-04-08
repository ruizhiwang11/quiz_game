import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/models/Student.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StudentController {

  StudentController();
  bool add_flag = false;
  bool is_student = false;

  void set_flag(bool flag) {
    add_flag = flag;
  }

  void set_student(bool flag) {
    is_student = flag;
  }

  Future<bool> addStudent(Student student) async {
    await FirebaseFirestore.instance
        .collection('students')
        .where('uid', isEqualTo: student.uid)
        .where('email', isEqualTo: student.email)
        .get()
        .then((users) {
      if (users.size != 0) {
        print("student already exists");
        set_flag(false);
      } else {
        set_flag(true);
      }
    });

    if (add_flag == false)
      return false;
    else {
      CollectionReference students = FirebaseFirestore.instance.collection('students');
      Future<void> addStudent() {
        // Call the user's CollectionReference to add a new user
        return students
            .add({
          'uid': student.uid,
          'email': student.email, // Stokes and Sons
        })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
      addStudent();
      set_flag(false);
      return true;
    }
  }

  Future<bool> checkStudentFromUID(String uid) async {
    is_student = false;
    await FirebaseFirestore.instance
        .collection('students')
        .where('uid', isEqualTo: uid)
        .get()
        .then((users) {
      if (users.size != 0) {
        set_student(true);
      } else {
        set_student(false);
      }
    });

    return is_student;
  }

  Future<bool> checkStudentFromEmail(String email) async {
    is_student = false;
    await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .get()
        .then((users) {
      if (users.size != 0) {
        set_student(true);
      } else {
        set_student(false);
      }
    });

    return is_student;
  }
}