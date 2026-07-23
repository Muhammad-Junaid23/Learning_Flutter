import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lecture_backend_services/models/city_model.dart';

class CityServices {
  String cityCollection = "CityCollection";

  //create city
  Future createCity(CityModel model) async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .add(model.toJson());
  }

  //update city
  Future updateCity(CityModel model) async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .update({"cityName": model.cityName, "population":model.population});
  }

  //delete city
  Future deleteCity(CityModel model) async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .delete();
  }

  //mark as visited city
  Future markAsVisitedCity(CityModel model) async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(model.docId)
        .update({"visited":model.visited});
  }

  //get all cities
  Stream<List<CityModel>> getAllCities(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .snapshots()
        .map((cityList) =>
        cityList.docs.map((cityJson) => CityModel.fromJson(cityJson.data())
        ).toList()
    );
  }

  //get all visited cities
  Stream<List<CityModel>> getAllVisitedCities(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("visited", isEqualTo: true)
        .snapshots()
        .map((cityList) =>
        cityList.docs.map((cityJson) => CityModel.fromJson(cityJson.data())
        ).toList()
    );
  }

  //get all remaining cities
  Stream<List<CityModel>> getAllRemainingCities(){
    return FirebaseFirestore.instance
        .collection(cityCollection)
        .where("visited", isEqualTo: false)
        .snapshots()
        .map((cityList) =>
        cityList.docs.map((cityJson) => CityModel.fromJson(cityJson.data())
        ).toList()
    );
  }

}