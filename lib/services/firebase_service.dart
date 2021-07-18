import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:g60/models/exercise.dart';
import 'package:g60/models/signinreponse.dart';


class FireStoreService {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future <bool> loginWithEmail({required String email, required String password,}) async {
    try {
      var user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }


  Future<void> saveRecordInFirestoreWithJsonString({required String jsonString, required String collection, required String id}) {
    Map<String, dynamic> data = json.decode(jsonString);
    return FirebaseFirestore.instance.runTransaction((Transaction transactionHandler) {
      return FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .set(data, SetOptions(merge: true));
    });
  }

  Future<void> saveRecordInFirestoreWithJson({required Map<String, dynamic> data, required String collection, required String id}) {
    return FirebaseFirestore.instance.runTransaction((Transaction transactionHandler) {
      return FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .set(data, SetOptions(merge: true));
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSingleFirebaseRecord({required String collection, required String id}) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .get();
  }

  Future<List<Exercise>> getExercises() async {

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('exercises')
        .get();

    List <Exercise> properties = List<Exercise>.from(query.docs.map((doc) => Exercise.fromSnapshot(snapshot: doc, data: doc.data() as Map<String, dynamic>)).toList());

    return properties;
  }

  static Future <SignInResponse?> getCurrentUser() async {

    final _auth = FirebaseAuth.instance;
    User loggedInUser;

    SignInResponse signInResponse = SignInResponse(id: '', newUser: true);

    try {

      var user =  _auth.currentUser;

      if (user != null){
        loggedInUser = user;
        signInResponse.id = loggedInUser.uid;
        signInResponse.newUser = false;

      } else {
        await _auth.signInAnonymously().then((value) {
          signInResponse.id = value.user!.uid;
          signInResponse.newUser = true;
        });
      }

      return signInResponse;

    } on Exception catch (e) {
      return null;
    }
  }



  // Future<void> updateFallInDatabase({Map<dynamic, dynamic> data, String collection}) {
  //
  //   return FirebaseFirestore.instance.runTransaction((Transaction transactionHandler) {
  //     return FirebaseFirestore.instance
  //         .collection(collection)
  //         .add(data);
  //   });
  // }

  void incrementFirestoreField({required String collection, required String id, required String fieldToIncrement}) {
    final DocumentReference docRef = FirebaseFirestore.instance.collection(collection).doc(id);
    docRef.update({fieldToIncrement: FieldValue.increment(1)});
  }

  Future<bool> deleteFirestoreRecord({required String collection, required String documentID}) async{
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentID)
        .delete();

    return true;
  }


}









