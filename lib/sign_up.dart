import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_camp/Home_screen.dart';
import 'package:proj_camp/Sign_in.dart';
import 'package:proj_camp/text_form.dart';

class SignUp extends StatefulWidget {
  static const String routeName = 'signUP' ;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState>formState = GlobalKey();

  final TextEditingController email =   TextEditingController() ;
  final  TextEditingController password =   TextEditingController() ;
  final  TextEditingController passwordConfirm =   TextEditingController() ;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,toolbarHeight: 50,),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width*.04
          ),
          child: Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Register new\naccount',style: TextStyle(fontSize: 35),),
                SizedBox(height: 7,),
                Row(
                  children: [
                    Container(
                      color: Colors.blue,
                      width: 90,
                      height: 3,
                    ),
                    SizedBox(width: 6,),
                    Container(
                      color: Colors.blue,
                      width: 11,
                      height: 3,
                    ),
                  ],
                ),
                SizedBox(height: 55,),
                TextForm(hint: 'Email', myController: email , validatorUser: (value) {
                  if(value?.length==0){
                    return 'Please enter email' ;
                  }
                },),
                SizedBox(height: 38,),
                TextForm(hint: 'Password', myController: password,validatorUser: (value) {
                  if(value?.length==0){
                    return 'Please enter password' ;
                  }
                }),
                SizedBox(height: 38,),
                TextForm(hint: 'Password Confirmation', myController: passwordConfirm,validatorUser: (value) {
                  if(value?.length==0){
                    return 'Please confirm password' ;
                  }
                }),

                SizedBox(height: 80,),
                InkWell(
                  onTap: () async {
                    if(formState.currentState!.validate()){
                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'warning',
                            desc:'The password provided is too weak.',
                          ).show();
                          setState(() {

                          });
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'warning',
                            desc:'The account already exists for that email.',
                          ).show();
                          setState(() {

                          });
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: e.toString(),
                        ).show();
                      }
                    }else{
                      print('Error valid');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 57,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text('Register',style: TextStyle(fontSize: 23 , color: Colors.white),)),
                  ),
                ),
                SizedBox(height: 100,),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(SignIn.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an acount?",style: TextStyle(fontSize: 18 , color: Colors.grey , fontWeight: FontWeight.w500),),
                      Text(" Login",style: TextStyle(fontSize: 18 , color: Colors.blue.shade700 , fontWeight: FontWeight.w500),),

                    ],
                  ),
                )









              ],),
          ),
        ),
      ),
    );
  }
}
