import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    //getUsers();
    //getUserById();
    //createUser();
    //updateUser();
    deleteUser();
    super.initState();
  }

  getUsers(){
    usersRef.getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.forEach((DocumentSnapshot doc){
        print(doc.data);
        print(doc.data['username']);
        print(doc.documentID);
        print(doc.exists);
      });
    });
  }

  getUserById() async{
    final String id = "dV14NzYK0pnBjAnvh062";
    final DocumentSnapshot doc = await usersRef.document(id).get();
    print(doc.data);
    print(doc.data['username']);
    print(doc.documentID);
    print(doc.exists);
  }

  createUser(){
    // usersRef
    //   .document("asdasdadad")
    //   .setData({"username": "Lalit", "postsCount": 0, "isAdmin": true});
    usersRef
      .add({"username": "Lalit", "postsCount": 0, "isAdmin": true});
  }

  updateUser() async {
    final DocumentSnapshot doc = await usersRef.document("asdasdadad").get();
    if(doc.exists){
      doc.reference
      .updateData({"username": "Sheena", "postsCount": 0, "isAdmin": true});
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc = await usersRef.document("asdasdadad").get();
    if(doc.exists){
      doc.reference.delete();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Widget> children = snapshot.data.documents
              .map((doc) => Text(doc['username']))
              .toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
