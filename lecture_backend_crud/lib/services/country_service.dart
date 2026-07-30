import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lecture_backend_crud/models/country_model.dart';

class CountryService {
  String countryCollection = "CountryCollection";

  //create country
  Future createCountry(CountryModel model)async{
    DocumentReference docRef =
     FirebaseFirestore
        .instance
        .collection(countryCollection)
        .doc();
     return await FirebaseFirestore.instance
         .collection(countryCollection)
         .doc(docRef.id)
         .set(model.toJson(docRef.id)
     );
  }

  // update country
  Future updateCountry(CountryModel model) async{
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(model.docId)
        .update({"countryName":model.countryName});
  }

  //delete country
  Future deleteCountry(String countryID) async{
    return await FirebaseFirestore.instance
        .collection(countryCollection)
        .doc(countryID)
        .delete();
  }

  //get all countries
  Stream<List<CountryModel>> getAllCountries(){
    return FirebaseFirestore.instance
        .collection(countryCollection)
        .snapshots()
        .map((countryList)=>countryList.docs
        .map((countryJson)=> CountryModel.fromJson(countryJson.data())
    ).toList());
  }

  // get countries
  Future<List<CountryModel>> getCountries(){
    return FirebaseFirestore.instance
        .collection(countryCollection)
        .get()
        .then((countryList)=> countryList.docs
        .map((countryJson)=> CountryModel.fromJson(countryJson.data())
    ).toList());
  }

}