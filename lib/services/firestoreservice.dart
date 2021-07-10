
import 'dart:convert';

class FireStoreService {
  //
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //
  // Future <bool> loginWithEmail({required String email, required String password,}) async {
  //   try {
  //     var user = await firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     return user != null;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }
  //
  //
  // Future<void> saveRecordInFirestoreWithJsonString({required String jsonString, required String collection, required String id}) {
  //   Map<String, dynamic> data = json.decode(jsonString);
  //   return FirebaseFirestore.instance.runTransaction((Transaction transactionHandler) {
  //     return FirebaseFirestore.instance
  //         .collection(collection)
  //         .doc(id)
  //         .set(data, SetOptions(merge: true));
  //   });
  // }
  //
  // Future<void> saveRecordInFirestoreWithJson({required Map<String, dynamic> data, required String collection, required String id}) {
  //   return FirebaseFirestore.instance.runTransaction((Transaction transactionHandler) {
  //     return FirebaseFirestore.instance
  //         .collection(collection)
  //         .doc(id)
  //         .set(data, SetOptions(merge: true));
  //   });
  // }
  //
  // Future<DocumentSnapshot<Map<String, dynamic>>> getSingleFirebaseRecord({required String collection, required String id}) async {
  //   return await FirebaseFirestore.instance
  //       .collection(collection)
  //       .doc(id)
  //       .get();
  // }
  //
  // Future<QuerySnapshot<Map<String, dynamic>>> getFirebaseRecords({required String collection, required String company, required String site}) async {
  //   return await FirebaseFirestore.instance
  //       .collection(collection)
  //       .where('company', isEqualTo: company)
  //       .where('site', isEqualTo: site)
  //       .get();
  // }
  //
  //

  // Future<void> updateFallInDatabase({Map<dynamic, dynamic> data, String collection}) {
  //
  //   return FirebaseFirestore.instance.runTransaction((Transaction transactionHandler) {
  //     return FirebaseFirestore.instance
  //         .collection(collection)
  //         .add(data);
  //   });
  // }
  //
  // void incrementFirestoreField({required String collection, required String id, required String fieldToIncrement}) {
  //   final DocumentReference docRef = FirebaseFirestore.instance.collection(collection).doc(id);
  //   docRef.update({fieldToIncrement: FieldValue.increment(1)});
  // }
  //
  // Future<bool> deleteFirestoreRecord({required String collection, required String documentID}) async{
  //    await FirebaseFirestore.instance
  //       .collection(collection)
  //       .doc(documentID)
  //       .delete();
  //
  //    return true;
  // }

  // void sendFeedbackEmail({required String name, required String feedback, required String subject}) async {
  //   await FirebaseFirestore.instance.collection(Strings.firestoreEmailsCollection).doc()
  //       .set({
  //     'to': Strings.feedbackEmail,
  //     'cc': Strings.feedbackCCEmail,
  //     'message': {
  //       'subject': subject,
  //         'html':
  //         'Name : ' + name ?? '' + '<br>'+
  //         'Feedback : ' + feedback ?? '',
  //     } });
  // }
}






