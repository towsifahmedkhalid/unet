import 'package:flutter/material.dart';
import 'package:unet/dashboard_screen.dart';
import 'package:unet/registration_screen.dart';
import 'package:unet/login_screen.dart';
import 'package:unet/customer_screen.dart';
import 'package:unet/dps_screen.dart';
import 'package:unet/fdr_screen.dart';
import 'package:unet/check_fdr.dart';
import 'package:unet/check_dps.dart';
import 'package:unet/apply_fdr.dart';
import 'package:unet/apply_dps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unet/final_registration_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: 'login_screen',
      routes: {
        'login_screen': (context) => LoginScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'customer_screen': (context) => CustomerScreen(),
        'dashboard_screen': (context) => Dashboard(),
        'fdr_screen': (context) => Fdr(),
        'dps_screen': (context) => Dps(),
        'apply_fdr': (context) => ApplyFdr(),
        'apply_dps': (context) => ApplyDps(),
        'check_fdr': (context) => CheckFdr(),
        'check_dps': (context) => CheckDps(),
        'final_registration_screen': (context) => FinalRegistrationScreen(),

      },
    );
  }
}





