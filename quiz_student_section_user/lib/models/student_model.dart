import 'dart:convert';

// StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));
//
// String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  final String? docId;
  final String? sectionId;
  final String? studentName;
  final int? studentAge;
  final String? studentCity;
  final bool? isPassed;
  final List<dynamic>? intelligent;
  final int? createdAt;

  StudentModel({
    this.docId,
    this.sectionId,
    this.studentName,
    this.studentAge,
    this.studentCity,
    this.isPassed,
    this.intelligent,
    this.createdAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    docId: json["docId"],
    sectionId: json["sectionId"],
    studentName: json["studentName"],
    studentAge: json["studentAge"],
    studentCity: json["studentCity"],
    isPassed: json["isPassed"],
    intelligent: json["intelligent"] == null ? [] : List<dynamic>.from(json["intelligent"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String studentId) => {
    "docId": studentId,
    "sectionId": sectionId,
    "studentName": studentName,
    "studentAge": studentAge,
    "studentCity": studentCity,
    "isPassed": isPassed,
    "intelligent": intelligent == null ? [] : List<dynamic>.from(intelligent!.map((x) => x)),
    "createdAt": createdAt,
  };
}