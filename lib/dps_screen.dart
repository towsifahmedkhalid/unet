import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unet/apply_dps.dart';
import 'package:unet/check_dps.dart';

class Dps extends StatefulWidget {
  const Dps({Key? key}) : super(key: key);

  @override
  State<Dps> createState() => _DpsState();
}

class _DpsState extends State<Dps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          //DPS Heading
          Container(
            margin: EdgeInsets.only(left: 20, top: 30),
            alignment: Alignment.topLeft,
            child: Text(
              'DPS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'San Francisco',
              ),
            ),
          ),

          //ApplyDps
          Container(
            margin: EdgeInsets.only(top: 100),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ApplyDps()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Create DPS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          //CheckDps
          Container(
            margin: EdgeInsets.only(top: 100),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckDps()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Check DPS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }
}

