import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  String hint ;
  String? Function(String?)? validatorUser;
  final TextEditingController myController ;

  TextForm({required this.hint , required this.myController , required this.validatorUser});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorUser,
      controller: myController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        hintText: hint ,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      ),
    );
  }
}
