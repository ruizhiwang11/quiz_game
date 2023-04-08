import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/controllers/student_controller.dart';
import 'package:quiz_game/controllers/teacher_controller.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserController _userController;
  AuthBloc(UserController userController)
      : _userController = userController,
        super(Uninit())
  {
    on<AppStarted>(_appStartedStateEmitter);
    on<LoggedInStudent>(_loggedInStudentStateEmitter);
    on<LoggedInTeacher>(_loggedInTeacherStateEmitter);
    on<LoggedOut>(_loggedOutStateEmitter);
  }

  void _appStartedStateEmitter(AppStarted event, Emitter<AuthState> emit) async{
    try {
      final isSignedIn = await _userController.isSignedIn();
      if (isSignedIn) {
        final uid = await _userController.getUser();
        StudentController studentController = StudentController();
        TeacherController teacherController = TeacherController();
        bool is_student = await studentController.checkStudentFromUID(uid);
        bool is_teacher = await teacherController.checkTeacherFromUID(uid);
        if (is_student && ! is_teacher){
          emit(AuthStudent(uid));
        }
        else if(! is_student &&  is_teacher){
          emit(AuthTeacher(uid));
        }
      } else {
        emit(UnAuth());
      }
    } catch (_) {
      emit(UnAuth());
    }
  }

  void _loggedInStudentStateEmitter(LoggedInStudent event, Emitter<AuthState> emit) async{
    emit(AuthStudent(await _userController.getUser()));
  }

  void _loggedInTeacherStateEmitter(LoggedInTeacher event, Emitter<AuthState> emit) async{
    emit(AuthTeacher(await _userController.getUser()));
  }

  void _loggedOutStateEmitter(LoggedOut event, Emitter<AuthState> emit) async{
    await _userController.signOut();
    emit(UnAuth());
  }
}
