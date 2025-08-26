import 'package:flutter/material.dart';
import 'package:unet/login_screen.dart';
import 'package:unet/dashboard_screen.dart';
import 'package:unet/fdr_screen.dart';
import 'package:unet/dps_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {

  int myIndex = 0;
  final screens = [
    Dashboard(),
    Fdr(),
    Dps(),
  ];

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Dashboard'),
          actions: <Widget> [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                }
            ),
          ],
        ),

        body: IndexedStack(
          index: myIndex,
          children: screens,
        ),

        bottomNavigationBar: BottomNavigationBar (
          type: BottomNavigationBarType.fixed,

          onTap: (index){
            setState(() {
              myIndex = index;
            });
          },

          currentIndex: myIndex,
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.savings_outlined),
              label: 'FDR',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.savings_sharp),
              label: 'DPS',
            ),

          ],
        ),



    );
  }
}
