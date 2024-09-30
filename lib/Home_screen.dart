import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proj_camp/Sign_in.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camp 2024'),
        actions: [
        InkWell(
          onTap: () async {
            GoogleSignIn googleSignIn = GoogleSignIn();
            googleSignIn.disconnect();
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed(SignIn.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.exit_to_app,size: 28,),
          ))
      ],),
      body: Container(
        color: Colors.brown,
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Text('Welcome',style: TextStyle(fontSize: 50 , color: Colors.white),)),
      ),
    );
      
      
  }
}