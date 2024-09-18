import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database_manager/model/app_user.dart';
import 'package:todo_app/database_manager/user_dao.dart';

class AppAuthProvider extends ChangeNotifier {
  AppUser? databaseUser;
  User? firebaseAuthUser;
  Future<void> register(
      {required String email,
      required String password,
      required String fullName,
      required String userName}) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    AppUser user = AppUser(
      id: credential.user?.uid,
      fullName: fullName,
      userName: userName,
      email: email,
    );
    await UsersDao.addUserToDatabase(user);
  }

  Future<void> login(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    databaseUser =await UsersDao.readUserFromDatabase(credential.user!.uid);
    firebaseAuthUser = credential.user;
notifyListeners();
  }

  void signOut(){
    databaseUser = null ;
    FirebaseAuth.instance.signOut();
  }

  bool isLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null ;
  }

  Future<void> retrieveUserFromDatabase() async{
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    databaseUser =await UsersDao.readUserFromDatabase(firebaseAuthUser!.uid);
    notifyListeners();

  }
}
