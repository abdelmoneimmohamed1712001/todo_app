import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database_manager/model/task.dart';
import 'package:todo_app/database_manager/user_dao.dart';

class TasksDao{
  static CollectionReference<Task>getTaskCollection(String uid){
    var userCollection = UsersDao.getUsersCollection();
    var userDoc = userCollection.doc(uid);
   return userDoc.collection('Tasks').withConverter(
      fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
      toFirestore: (task, options) => task.toFireStore(),);
  }
  static Future<void>addTask(Task task,String uid){
    var tasksCollection = getTaskCollection(uid);
    var taskDoc = tasksCollection.doc();
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }
  static  Future<void>updateTask(Task task , String uid)async{
    var taskCollection = getTaskCollection(uid);
     await taskCollection.doc(task.id).update(task.toFireStore());

  }

  static Future<List<Task>>readAllTasks(String uid)async{
    var tasksCollection = getTaskCollection(uid);
    var taskSnapshot = await tasksCollection.get();
    var taskList = taskSnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
    return taskList ;
  }
  static Stream<QuerySnapshot<Task>> getAllTasksRealTime(String uid,DateTime selectDate)async*{
    var tasksCollection = getTaskCollection(uid).where('taskDate',isEqualTo: selectDate);
    var stream = await tasksCollection.snapshots();
    yield* stream ;
  }

  static Future<void> deleteTask(String uid,String id)async{
    var tasksCollection = getTaskCollection(uid);
    await tasksCollection.doc(id).delete();

  }

}