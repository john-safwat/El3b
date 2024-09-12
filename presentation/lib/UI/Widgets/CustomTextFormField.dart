import 'package:core/Theme/Theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  IconData icon;
  CustomTextFormField(
      {required this.label,
        required this.controller,
        required this.inputType,
        required this.validator,
        required this.icon
      });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textTheme.displayMedium,
      cursorColor: MyTheme.lightPurple,
      keyboardType: inputType,
      validator: (value) => validator(value),
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: label,
        hintStyle: textTheme.displayMedium,
        prefixIcon: Icon(icon , color: MyTheme.lightPurple, size: 30,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:const BorderSide(
              width: 2,
              color: MyTheme.lightPurple,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:const BorderSide(
            width: 2,
            color: MyTheme.lightPurple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: MyTheme.lightPurple,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
      ),
    );
  }
}