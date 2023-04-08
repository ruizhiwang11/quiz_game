import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/models/Teacher.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TeacherController {

  TeacherController();
  bool add_flag = false;
  bool is_teacher = false;


  void set_flag(bool flag) {
    add_flag = flag;
  }
  void set_teacher(bool flag) {
    is_teacher = flag;
  }

  Future<bool> addTeacher(Teacher teacher) async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .where('uid', isEqualTo: teacher.uid)
        .where('email', isEqualTo: teacher.email)
        .get()
        .then((users) {
      if (users.size != 0) {
        print("teacher already exists");
        set_flag(false);
      } else {
        set_flag(true);
      }
    });

    if (add_flag == false)
      return false;
    else {
      CollectionReference students = FirebaseFirestore.instance.collection('teachers');
      Future<void> addStudent() {
        // Call the user's CollectionReference to add a new user
        return students
            .add({
          'uid': teacher.uid,
          'email': teacher.email, // Stokes and Sons
        })
            .then((value) => print("teacher Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
      addStudent();
      set_flag(false);
      return true;
    }
  }

  Future<bool> checkTeacherFromUID(String uid) async {
    is_teacher = false;
    await FirebaseFirestore.instance
        .collection('teachers')
        .where('uid', isEqualTo: uid)
        .get()
        .then((users) {
      if (users.size != 0) {
        set_teacher(true);
      } else {
        set_teacher(false);
      }
    });

    return is_teacher;
  }

  Future<bool> checkTeacherFromEmail(String email) async {
    is_teacher = false;
    await FirebaseFirestore.instance
        .collection('teachers')
        .where('email', isEqualTo: email)
        .get()
        .then((users) {
      if (users.size != 0) {
        set_teacher(true);
      } else {
        set_teacher(false);
      }
    });

    return is_teacher;
  }
}