import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CheckFdr extends StatefulWidget {
  const CheckFdr({Key? key}) : super(key: key);

  @override
  State<CheckFdr> createState() => _CheckFdrState();
}

class _CheckFdrState extends State<CheckFdr> {

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('FDR Requests'),
      ),

      body:
      Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("fdr")
                .where("userId", isEqualTo: userId?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){


              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: Text("No Data Found!"),
                );
              }

              if(snapshot != null && snapshot.data != null){
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      var amount = snapshot.data!.docs[index]['amount'];
                      var status = snapshot.data!.docs[index]['status'];
                      return Card(
                        child: ListTile(
                          title: Text(
                            'Amount: $amount ',
                          ),
                          subtitle: Text( 'Status: $status'),

                        ),
                      );

                    }
                );
              }
              return Container();
            }
        ),
      ),


    );
  }
}
