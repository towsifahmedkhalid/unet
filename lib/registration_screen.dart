import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:unet/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registration'),
      ),
      body: Column(
        children: [

          //Text 1
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Text(
              'Lets Start a New Journey!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),

          //Text 2
          Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 10),
            child: Text(
              'Welcome to the self-registration page for the Unet. Enter your desired password and email address.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),


          //Email
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 40),
            child: TextField(
              controller: userEmailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Email',
              ),
            ),
          ),

          //Password
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            child: TextField(
              controller: userPasswordController,
              obscureText: true,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Password',
              ),
            ),
          ),

          //Register
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [

                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                        'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {

                      var userEmail = userEmailController.text.trim();
                      var userPassword = userPasswordController.text.trim();


                      try {
                        final newUser = await _auth
                            .createUserWithEmailAndPassword(
                              email: userEmail, password: userPassword)
                            .then((value) => {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(currentUser!.uid)
                                  .set({

                                'userEmail': userEmail,
                                'userPassword': userPassword,
                                'createdAt': DateTime.now(),
                                'userId': currentUser!.uid,

                              }),
                            });
                        if(newUser != null) {
                          Navigator.pushNamed(context, 'login_screen');
                        }
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
                        'Sign Up'
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
