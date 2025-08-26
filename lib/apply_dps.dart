import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:unet/customer_screen.dart';



class ApplyDps extends StatefulWidget {
  const ApplyDps({Key? key}) : super(key: key);

  @override
  State<ApplyDps> createState() => _ApplyDpsState();
}

class _ApplyDpsState extends State<ApplyDps> {

  String dropDownTenor = '3 Years';

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
        title: Text('Apply DPS'),
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

          //Text-Tenor
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
                    items: <String>[ '3 Years', '5 Years', '10 Years']
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
                hintText: 'Monthly Installment Amount',
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
                        await FirebaseFirestore.instance.collection('dps').doc().set({
                          'createdAt': DateTime.now(),
                          'name': name,
                          'account': account,
                          'userId': userId?.uid,
                          'tenor': dropDownTenor,
                          'amount': amount,
                          'status': 'on wait',
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(' DPS Form Submitted Successfully!'),
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
