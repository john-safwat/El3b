import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  String label;
  TextEditingController controller;
  TextInputType inputType;
  Function validator;
  IconData icon;
  CustomPasswordTextFormField(
      {required this.label,
        required this.controller,
        required this.inputType,
        required this.validator,
        required this.icon
      });

  @override
  State<CustomPasswordTextFormField> createState() => _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState extends State<CustomPasswordTextFormField> {
  bool visiabel = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textTheme.displayMedium,
      cursorColor: MyTheme.lightPurple,
      keyboardType: widget.inputType,
      validator: (value) => widget.validator(value),
      cursorHeight: 20,
      obscureText: !visiabel,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: widget.label,
        hintStyle: textTheme.displayMedium,
        prefixIcon: Icon(widget.icon , color: MyTheme.lightPurple, size: 30,),
        suffixIcon: InkWell(

          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            setState(() {
              visiabel = !visiabel;
            });
          },
          child: visiabel
              ? const Icon(
            AntDesign.eye_invisible_fill,
            color: MyTheme.lightPurple,
          )
              : const Icon(
            AntDesign.eye_fill,
            color: MyTheme.lightPurple,
          ),
        ),
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
