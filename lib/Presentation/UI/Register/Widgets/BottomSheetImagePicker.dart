import 'package:El3b/Core/Theme/Theme.dart';
import 'package:flutter/material.dart';

class MyBottomSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,

      decoration: const BoxDecoration(
          color: MyTheme.purple,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: const Text(
              "Select Picking Image Method",
              style: TextStyle(color: MyTheme.offWhite),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.lightPurple,
                ),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 40,
                child: const Text(
                  "Gallery",
                  style: TextStyle(color: MyTheme.offWhite),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.lightPurple,
                ),
                padding: const EdgeInsets.all(10),
                width: 150,
                height: 40,
                child: const Text(
                  "Camera",
                  style: TextStyle(color: MyTheme.offWhite),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
