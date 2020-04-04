import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

final userRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() { 
    //getUsers();
    getUserById();
    super.initState();
  }

  getUsers(){
    userRef.getDocuments().then((QuerySnapshot snapshot){
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
    final DocumentSnapshot doc = await userRef.document(id).get();
    print(doc.data);
    print(doc.data['username']);
    print(doc.documentID);
    print(doc.exists);
  }

  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Text("Timeline"),
    );
  }
}
