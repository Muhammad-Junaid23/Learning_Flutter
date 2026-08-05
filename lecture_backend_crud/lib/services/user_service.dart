

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lecture_backend_crud/models/user_model.dart';

class UserService {
  String userCollection = "UserCollection";

  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson());
  }

  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({"name": model.name,"address":model.address,"phone":model.phone});
  }

  Future deleteUser(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }

  Future<UserModel> getUserByID(String userID)async{
      return await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userID)
          .get()
          .then((user)=>UserModel.fromJson(user.data()!));
  }

}