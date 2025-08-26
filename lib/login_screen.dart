import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unet/registration_screen.dart';
import 'package:unet/customer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final _auth =  FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In'),
      ),
        body: Column(
          children: [

            //Image
            Container(
              margin: EdgeInsets.only(top: 25),
              height: 150,
              width: 500,
              child: Image(
                image: AssetImage('images/unet_logo.jpg'),
              ),
            ),
            
            //Email
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, top: 50),
              child: TextField(
                controller: loginEmailController,
                keyboardType: TextInputType.emailAddress,
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
                controller: loginPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  hintText: 'Password',

                ),
              ),
            ),

            //SignInAsCustomer
            Container(
              margin: EdgeInsets.only(top: 40),
              child: SizedBox(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    var loginEmail = loginEmailController.text.trim();
                    var loginPassword = loginPasswordController.text.trim();
                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail, password: loginPassword))
                      .user;
                      if (firebaseUser!= null) {
                        Navigator.pushNamed(context, 'customer_screen');
                      }
                    }
                    catch(e){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Wrong Email or Password'),
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
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                      'Sign In'
                  ),
                ),
              ),
            ),

            //SignUp
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text(
                    'New in Unet?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
    );
  }
}
