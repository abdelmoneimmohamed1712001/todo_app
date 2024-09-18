import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database_manager/model/app_user.dart';

class UsersDao{
  static CollectionReference<AppUser>getUsersCollection(){
    var db = FirebaseFirestore.instance;
    return db.collection('Users').withConverter<AppUser>(
      fromFirestore: (snapshot, options) => AppUser.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),);
  }
  static Future<void>addUserToDatabase(AppUser user){
    var usersCollection = getUsersCollection();
    var userDoc = usersCollection.doc(user.id);
    return userDoc.set(user);
  }

  static Future<AppUser?>readUserFromDatabase(String uid)async{
    var usersCollection = getUsersCollection();
    var docRef = usersCollection.doc(uid);
    var docSnapshot =await docRef.get();
    return docSnapshot.data();
  }
}