import 'package:amir_backend/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  ///Get User By ID
  Future<UserModel> getUserByID(String userID) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(userID)
        .get()
        .then((val) {
          return UserModel.fromJson(val.data()!);
        });
  }

  ///Update Profile
  Future updateProfile(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(model.docId)
        .update({
          'name': model.name,
          'phone': model.phone,
          'address': model.address,
        });
  }
}
