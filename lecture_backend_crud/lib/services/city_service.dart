import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lecture_backend_crud/models/city_model.dart';

class CityService{
  String cityCollection = "CityCollection";

  ///Create City
  Future createCity(CityModel model)async{
        DocumentReference docRef =
       await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
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
  Future deleteCity(String cityID)async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(cityID)
        .delete();
  }
  ///Mark As Visited Cities
  Future markAsVisitedCities(String cityID, bool visited)async{
    return await FirebaseFirestore.instance
        .collection(cityCollection)
        .doc(cityID)
        .update({"visited" : visited});
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

    ///get All Saved Cities
    Stream<List<CityModel>> getAllSaved(String userID){
      return FirebaseFirestore.instance
          .collection(cityCollection)
          .where("saved" , arrayContains: userID)
          .snapshots()
          .map((cityList) => cityList.docs
          .map((cityJson) => CityModel.fromJson(cityJson.data())
      ).toList());
    }

        ///add to Saved
        Future addToSaved({
          required String userID,
          required String cityID,
        })
        async{
          return await FirebaseFirestore.instance
              .collection(cityCollection)
              .doc(cityID)
              .update({"saved" : FieldValue.arrayUnion([userID])});
        }

        ///remove from Saved
        Future removeFromSaved({
          required String userID,
          required String cityID,
        })
        async{
          return await FirebaseFirestore.instance
              .collection(cityCollection)
              .doc(cityID)
              .update({"saved" : FieldValue.arrayRemove([userID])});
        }

}
