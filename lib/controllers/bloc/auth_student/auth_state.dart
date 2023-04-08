 part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class Uninit extends AuthState {}

class AuthStudent extends AuthState {
  final String UID;
  const AuthStudent(this.UID);

  @override
  List<Object> get props => [UID];

  @override
  String toString() => "Auth $UID";
}

class AuthTeacher extends AuthState {
   final String UID;
   const AuthTeacher(this.UID);

   @override
   List<Object> get props => [UID];

   @override
   String toString() => "Auth $UID";
 }

class AuthButNotSet extends AuthState {
  final String UID;
  const AuthButNotSet(this.UID);

  @override
  List<Object> get props => [UID];
}

class UnAuth extends AuthState {}
