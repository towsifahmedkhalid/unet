import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unet/final_registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final _auth = FirebaseAuth.instance;
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Column(
        children: [


          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color:Colors.black,
                width: 2,
              ),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("userinfo")
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
                          var userName = snapshot.data!.docs[index]['userName'];
                          var userAccount = snapshot.data!.docs[index]['userAccount'];
                          return Card(
                            child: ListTile(
                              title: Text(
                                'Name: $userName ',
                              ),
                              subtitle: Text( 'Account: $userAccount'),

                            ),
                          );

                        }
                    );
                  }
                  return Container();
                }
            ),
          ),

          //Register
          Container(
            margin: EdgeInsets.only(top: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [

                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FinalRegistrationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Final Registration',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),


        ],
      ),




    );
  }
}
