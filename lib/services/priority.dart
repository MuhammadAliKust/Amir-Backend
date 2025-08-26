import 'package:amir_backend/models/priority.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PriorityServices {
  ///Create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Update Priority
  Future updatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .update({'name': model.name});
  }

  ///Delete Priority
  Future deletePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .delete();
  }

  ///Get All Priorities
  Stream<List<PriorityModel>> getAllPriorities() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .snapshots()
        .map(
          (list) => list.docs
              .map((json) => PriorityModel.fromJson(json.data()))
              .toList(),
        );
  }
}
