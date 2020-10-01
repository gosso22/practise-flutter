import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel {
  String todoId;
  String content;
  bool done;

  ToDoModel({
    this.todoId,
    this.content,
    this.done,
  });

  ToDoModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    todoId = documentSnapshot.id;
    content = documentSnapshot.data()['content'] as String;
    done = documentSnapshot.data()['done'] as bool;
  }
}
