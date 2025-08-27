import 'package:amir_backend/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('taskCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'title': model.title, 'description': model.description});
  }

  ///Delete Task
  Future deleteTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .delete();
  }

  ///Mark as Complete
  Future markTaskAsComplete(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'isCompleted': true});
  }

  ///Get All Task
  Stream<List<TaskModel>> getAllTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get Task By Priority ID
  Stream<List<TaskModel>> getTaskByPriorityID(String priorityID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('priorityID', isEqualTo: priorityID)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Get Priority Task
}
