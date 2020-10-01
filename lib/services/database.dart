import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  Stream<List<ToDoModel>> streamToDo({String uid}) {
    try {
      return firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .where("done", isEqualTo: false)
          .snapshots()
          .map((query) {
        final List<ToDoModel> retVal = <ToDoModel>[];
        for (final DocumentSnapshot doc in query.docs) {
          print(ToDoModel.fromDocumentSnapshot(documentSnapshot: doc));
          retVal.add(ToDoModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToDo({String uid, String content}) async {
    try {
      firestore.collection("todos").doc(uid).collection("todos").add({
        "content": content,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateToDo({String uid, String todoId}) async {
    try {
      firestore
          .collection("todos")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}
