import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:unet/customer_screen.dart';

class ApplyFdr extends StatefulWidget {
  const ApplyFdr({Key? key}) : super(key: key);

  @override
  State<ApplyFdr> createState() => _ApplyFdrState();
}

class _ApplyFdrState extends State<ApplyFdr> {

  String dropDownTenor = '90 Days';
  String dropDownTenor1 = 'No';
  String dropDownTenor2 = 'Not Applicable';


  TextEditingController nameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('FDR Form'),
      ),

      body: Column(
        children: [

          //Name
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 40),
            child: TextField(
              controller: nameController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Full Name',
              ),
            ),
          ),

          //Account Number
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: TextField(
              controller: accountController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'Account Number',
              ),
            ),
          ),

          //Tenor
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Row(
              children: <Widget> [

                //Text-Tenor
                Container(
                  child: Text(
                    'Tenor:',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'San Francisco',
                    ),
                  ),
                ),

                //Tenor
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: DropdownButton<String>(
                    value: dropDownTenor,

                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownTenor = newValue!;
                      });
                    },
                    items: <String>[ '90 Days', '180 Days', '360 Days', '1 Month', '3 Months', '4 Months', '6 Months', '7 Months', '12 Months', '13 Months', '24 Months', '25 Months', '36 Months']
                        .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

              ],
            ),
          ),

          //AutoRenewal
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Row(
              children: <Widget> [

                //Text-AutoRenewal
                Container(
                  child: Text(
                    'Auto Renewal?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'San Francisco',
                    ),
                  ),
                ),

                //AutoRenewal
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: DropdownButton<String>(
                    value: dropDownTenor1,

                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownTenor1 = newValue!;
                      });
                    },
                    items: <String>[ 'Yes', 'No']
                        .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

              ],
            ),
          ),

          //Renewal Type
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Row(
              children: <Widget> [

                //Text-RenewalType
                Container(
                  child: Text(
                    'Renewal Type?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'San Francisco',
                    ),
                  ),
                ),

                //Renewal Type
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    value: dropDownTenor2,

                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownTenor2 = newValue!;
                      });
                    },
                    items: <String>[ 'Renew Principal & Interest', 'Renew Principal only', 'Not Applicable']
                        .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

              ],
            ),
          ),

          //Amount
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: TextField(
              controller: amountController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[700]),
                hintText: 'FDR Amount',
              ),
            ),
          ),

          //Apply Dps
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

                      var name = nameController.text.trim();
                      var account = accountController.text.trim();
                      var amount = amountController.text.trim();

                      try{
                        await FirebaseFirestore.instance.collection('fdr').doc().set({
                          'createdAt': DateTime.now(),
                          'name': name,
                          'account': account,
                          'userId': userId?.uid,
                          'tenor': dropDownTenor,
                          'autoRenewal': dropDownTenor1,
                          'renewalType': dropDownTenor2,
                          'amount': amount,
                          'status': 'on wait',
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(' FDR Form Submitted Successfully!'),
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
                        'Apply'
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
