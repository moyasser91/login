import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proj_camp/Home_screen.dart';
import 'package:proj_camp/sign_up.dart';
import 'package:proj_camp/text_form.dart';

class SignIn extends StatefulWidget {
  static const String routeName = 'signIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser == null)
      {
        return ;
      }

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

   await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .04),
          child: Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login to your\naccount',
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.blue,
                      width: 90,
                      height: 3,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      color: Colors.blue,
                      width: 11,
                      height: 3,
                    ),
                  ],
                ),
                SizedBox(
                  height: 55,
                ),
                TextForm(
                  hint: 'Email',
                  myController: email,
                  validatorUser: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 38,
                ),
                TextForm(
                  hint: 'Password',
                  myController: password,
                  validatorUser: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        // Navigate to the Home Screen if login is successful
                        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                      } on FirebaseAuthException catch (e) {
                        print('FirebaseAuthException caught: ${e.code}');
                        if (e.code == 'user-not-found') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'No user found for that email.',
                          ).show();
                          print('No user found dialog shown');
                        } else if (e.code == 'wrong-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Wrong password provided for that user.',
                          ).show();
                          print('Wrong password dialog shown');
                        }
                      } catch (e) {
                        // Handle any other types of errors
                        print('Error: $e');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: e.toString(),
                        ).show();
                      }
                    } else {
                      print('Form is not valid');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 57,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    )),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: Center(
                      child: Text(
                        'Log in With Google ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                SizedBox(
                  height: 110,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUp.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " Register",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
