import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_student_section_user/models/student_model.dart';

class StudentService{
  String studentCollection = "StudentCollection";

  ///Create student
  Future createStudent(StudentModel model)async{
    DocumentReference docRef =
    await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Get All students
  Stream<List<StudentModel>> getAllStudents(){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .snapshots()
        .map((studentList) => studentList.docs
        .map((studentJson) => StudentModel.fromJson(studentJson.data())
    ).toList());
  }

  ///Update student
  Future updateStudent(StudentModel model)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(model.docId)
        .update({"studentName" : model.studentName,
      "studentAge" : model.studentAge,
      "studentCity": model.studentCity,
    });
  }


  ///Delete student
  Future deleteStudent(String studentId)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentId)
        .delete();
  }

  ///Mark As passed student
  Future markAsPassedStudent(String studentId, bool isPassed)async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentId)
        .update({"isPassed" : isPassed});
  }

  ///Get All passed students
  Stream<List<StudentModel>> getAllPassedStudents(){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("isPassed", isEqualTo: true)
        .snapshots()
        .map((studentList) => studentList.docs
        .map((studentJson) => StudentModel.fromJson(studentJson.data())
    ).toList());
  }

  ///Get All failed students
  Stream<List<StudentModel>> getAllFailedStudents(){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("isPassed", isEqualTo: false)
        .snapshots()
        .map((studentList) => studentList.docs
        .map((studentJson) => StudentModel.fromJson(studentJson.data())
    ).toList());
  }

  ///get All intelligent students
  Stream<List<StudentModel>> getAllIntelligentStudents(String userID){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("intelligent" , arrayContains: userID)
        .snapshots()
        .map((studentList) => studentList.docs
        .map((studentJson) => StudentModel.fromJson(studentJson.data())
    ).toList());
  }

  ///Add Student To Intelligent List
  Future addToIntelligentList({
    required String userID,
    required String studentId,
  })
  async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentId)
        .update({"intelligent" : FieldValue.arrayUnion([userID])});
  }

  ///remove Student To Intelligent List
  Future removeFromIntelligentList({
    required String userID,
    required String studentId,
  })
  async{
    return await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(studentId)
        .update({"intelligent" : FieldValue.arrayRemove([userID])});
  }


  // get student by section ID
  Stream<List<StudentModel>> getStudentBySectionID(String sectionId){
    return FirebaseFirestore.instance
        .collection(studentCollection)
        .where("sectionId", isEqualTo: sectionId)
        .snapshots()
        .map((studentList) => studentList.docs
        .map((studentJson) => StudentModel.fromJson(studentJson.data())
    ).toList());
  }
}