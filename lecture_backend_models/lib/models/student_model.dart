import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) =>
    json.encode(data.toJson());

class StudentModel {
  final String studentId;
  final String name;
  final String email;
  final int? age;
  final String? createdAt;

  StudentModel({
    required this.studentId,
    required this.name,
    required this.email,
    this.age,
    this.createdAt
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
      studentId: json["studentId"],
      name: json["name"],
      email: json["email"],
      age: json["age"],
      createdAt: json["createdAt"],
  );


  Map<String, dynamic> toJson() => {
    "studentId": studentId,
    "name":name,
    "email":email,
    "age":age,
    "createdAt":createdAt
  };

}