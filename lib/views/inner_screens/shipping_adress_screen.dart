import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAdressScreen extends StatefulWidget {
  const ShippingAdressScreen({super.key});

  @override
  State<ShippingAdressScreen> createState() => _ShippingAdressScreenState();
}

class _ShippingAdressScreenState extends State<ShippingAdressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String state;
  late String city;
  late String locality;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
        0.96,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(
          0.96,
        ),
        title: Text(
          'Delivery',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'where will your order \nbe shipped?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    letterSpacing: 3,
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    state = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'State',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'City',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    locality = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter field';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Locality',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              //upadate user locality,city,state pincode
              _showDialog(context);
              await _firestore
                  .collection('buyers')
                  .doc(_auth.currentUser!.uid)
                  .update({
                'state': state,
                'locality': locality,
                'city': city,
              }).whenComplete(() {
                Navigator.of(context).pop();
                setState(() {
                  _formKey.currentState!.validate();
                });
              });
            } else {}
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(
                  0xFF1532E7,
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(
                child: Text(
                  'Add Address',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text('Updating Address'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text('Please wait ....')
              ],
            ),
          );
        }));

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }
}
