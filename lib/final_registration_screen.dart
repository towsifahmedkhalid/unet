import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FinalRegistrationScreen extends StatefulWidget {
  const FinalRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<FinalRegistrationScreen> createState() => _FinalRegistrationScreenState();
}

class _FinalRegistrationScreenState extends State<FinalRegistrationScreen> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController userNumberController = TextEditingController();
  TextEditingController userAccountController = TextEditingController();
  TextEditingController userUsernameController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Final Registration'),
      ),

      body: Column(
        children: [

          //Name
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 50),
            child: TextField(
              controller: userNameController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Full Name',
              ),
            ),
          ),

          //Phone Number
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            child: TextField(
              controller: userNumberController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Phone Number',
              ),
            ),
          ),

          //Account Number
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            child: TextField(
              controller: userAccountController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Account Number',
              ),
            ),
          ),

          //Username
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            child: TextField(
              controller: userUsernameController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Username',
              ),
            ),
          ),

          //Final
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [

                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      var userName = userNameController.text.trim();
                      var userNumber = userNumberController.text.trim();
                      var userAccount = userAccountController.text.trim();
                      var userUsername = userUsernameController.text.trim();

                      try{
                        await FirebaseFirestore.instance.collection('userinfo').doc(userId?.uid).set({
                          'createdAt': DateTime.now(),
                          'userName': userName,
                          'userNumber': userNumber,
                          'userAccount': userAccount,
                          'userUsername': userUsername,
                          'userId': userId?.uid,

                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Submitted!'),
                              actions: [
                                ElevatedButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }

                      catch(e){
                        print(e);
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                        'Submit'
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
