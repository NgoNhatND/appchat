
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDataBase{
  // final DatabaseReference ref = FirebaseDatabase.instance.ref();


  // CollectionReference users = FirebaseFirestore.instance.collection('users');

   static Future<void> addUser(String name,String message)async {
     final prefs = await SharedPreferences.getInstance();
     // var email = MySharedPrefere.getEmail();
     var email = prefs.getString('mail');
    // Call the user's CollectionReference to add a new user
     CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.add({
      'name': email,
      'message': message,
      'time': DateTime.now(),


    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  static Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('users').orderBy('time').snapshots();

}


















// import 'package:chat_firebase/model/message.dart';
// import 'package:chat_firebase/utils/constant.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class MessageService {
//   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final db = FirebaseFirestore.instance;
//   late CollectionReference refMessage;
//
//   Future sendMessage(String message) async {
//     final newMessage = Message(
//       userId: _firebaseAuth.currentUser!.uid,
//       userName: _firebaseAuth.currentUser!.displayName ?? "N/A",
//       roomId: ROOM_ID,
//       message: message.trim(),
//       messageType: MessageType.text,
//       createdAt: DateTime.now(),
//     );
//
//     try {
//       refMessage = db.collection(ROOM_COLLECTION);
//       var res = await refMessage.add(newMessage.toJson());
//       print(res);
//       return {"status" : true, "message" : "success"};
//     } on FirebaseAuthException catch (e) {
//       return {"status" : false, "message" : e.message.toString()};
//     }
//   }
//
//   Stream<QuerySnapshot> getMessageStream(int limit) {
//     return db.collection(ROOM_COLLECTION)
//         // .where('message', isEqualTo: "Hi")
//         .orderBy('createdAt')
//         // .limit(limit)
//         .snapshots();
//   }
//
// }