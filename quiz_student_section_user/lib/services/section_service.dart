import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_student_section_user/models/section_model.dart';

class SectionService {
  String sectionCollection = "SectionCollection";

  //create Section
  Future createSection(SectionModel model)async{
    DocumentReference docRef =
    await FirebaseFirestore
        .instance
        .collection(sectionCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(sectionCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id)
    );
  }

  // update Section
  Future updateSection(SectionModel model) async{
    return await FirebaseFirestore.instance
        .collection(sectionCollection)
        .doc(model.docId)
        .update({"sectionName":model.sectionName});
  }

  //delete Section
  Future deleteSection(String sectionID) async{
    return await FirebaseFirestore.instance
        .collection(sectionCollection)
        .doc(sectionID)
        .delete();
  }

  //get all sections
  Stream<List<SectionModel>> getAllSections(){
    return FirebaseFirestore.instance
        .collection(sectionCollection)
        .snapshots()
        .map((sectionList)=>sectionList.docs
        .map((sectionJson)=> SectionModel.fromJson(sectionJson.data())
    ).toList());
  }

  // get sections
  Future<List<SectionModel>> getSections(){
    return FirebaseFirestore.instance
        .collection(sectionCollection)
        .get()
        .then((sectionList)=> sectionList.docs
        .map((sectionJson)=> SectionModel.fromJson(sectionJson.data())
    ).toList());
  }

}