import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lecture_backend_crud/models/city_model.dart';

class CityService{
  String cityCollection = "CityCollection";

  ///Create City
  Future createCity(CityModel model)async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .add(model.toJson());
  }
  ///Update City
  Future updateCity(CityModel model)async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .update({"cityName" : model.cityName,
      "population" : model.population,});
  }
  ///Delete City
  Future deleteCity(CityModel model)async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .delete();
  }
  ///Mark As Visited Cities
  Future markAsVisitedCities(CityModel model)async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .update({"visited" : model.visited});
  }
  ///Get All Cities
  Stream<List<CityModel>> getAllCities(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .snapshots()
        .map((cityList) => cityList.docs
        .map((cityJson) => CityModel.fromJson(cityJson.data())
    ).toList());
  }
  ///Get All Visited Cities
  Stream<List<CityModel>> getAllVisitedCities(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("visited", isEqualTo: true)
        .snapshots()
        .map((cityList) => cityList.docs
        .map((cityJson) => CityModel.fromJson(cityJson.data())
    ).toList());
  }
  ///Get All Remaining Cities
  Stream<List<CityModel>> getAllRemainingCities(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("visited", isEqualTo: false)
        .snapshots()
        .map((cityList) => cityList.docs
        .map((cityJson) => CityModel.fromJson(cityJson.data())
    ).toList());
  }
}