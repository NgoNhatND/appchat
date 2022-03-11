import 'package:app_chat_test/pages/view/login_page.dart';
import 'package:app_chat_test/pages/services/message.dart';
import 'package:app_chat_test/pages/ultil/my_shared_prefere.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController edtController = TextEditingController();
  final loginEmail = FirebaseAuth.instance.currentUser?.email.toString();

  // TextEditingController emailController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Message',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  MySharedPrefere.removeEmail();
                  Navigator.push(context, MaterialPageRoute (
                      builder: (BuildContext context) => const LoginPage()));
                },
                icon: Icon(
                  Icons.logout,
                  size: 35,
                  color: Colors.orange,
                ))
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: MessageDataBase.usersStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Column(
                              crossAxisAlignment: loginEmail == data['name']
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: loginEmail == data['name']
                                            ? Colors.lightBlueAccent
                                            : Colors.greenAccent),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data['name']),
                                        Text(data['message']),
                                      ],
                                    )),

                                // ListTile(
                                // title: Text(data['name']),
                                // subtitle: Text(data['message']),
                                // ),
                              ],
                            );
                          }).toList(),
                        );
                      })),
              Container(
                decoration: const BoxDecoration(color: Colors.black12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: edtController,
                        decoration: InputDecoration(hintText: 'Enter'),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (edtController.text.isNotEmpty) {
                            MessageDataBase.addUser(
                                'name1', edtController.text.trim());
                            edtController.clear();
                          }

                          print('${DateTime.now().toString()}');
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.blue,
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
