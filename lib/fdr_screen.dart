import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unet/apply_fdr.dart';
import 'package:unet/check_fdr.dart';

class Fdr extends StatefulWidget {
  const Fdr({Key? key}) : super(key: key);

  @override
  State<Fdr> createState() => _FdrState();
}

class _FdrState extends State<Fdr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          //FDR Heading
          Container(
            margin: EdgeInsets.only(left: 20, top: 30),
            alignment: Alignment.topLeft,
            child: Text(
              'FDR',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'San Francisco',
              ),
            ),
          ),

          //ApplyFdr
          Container(
            margin: EdgeInsets.only(top: 100),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ApplyFdr()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Apply FDR',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          //CheckFdr
          Container(
            margin: EdgeInsets.only(top: 100),
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckFdr()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Check FDR',
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
