import 'package:El3b/Core/Theme/Theme.dart';
import 'package:El3b/Core/Utils/NegativeActionButton.dart';
import 'package:El3b/Core/Utils/PosActionButton.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MyDialogUtils {
  static Future<void> showLoadingDialog({
    required BuildContext context,
    required String message,
    required Color backgroundColor
  }) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding:const EdgeInsets.all(30),
          content: Row(
            children: [
              CircularProgressIndicator(
                color: backgroundColor == MyTheme.purple? MyTheme.offWhite : MyTheme.lightPurple,
              ),
              const SizedBox(
                width: 20,
              ),
              FittedBox(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: backgroundColor == MyTheme.purple? MyTheme.offWhite : MyTheme.lightPurple,
                    fontWeight: FontWeight.w400
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }

  static hideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static showFailMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  }) {

    List<Widget> actionList = [];

    // add the button to the action list if it doesn't equal null
    if(negativeActionTitle != null){
      if(negativeAction != null){
        actionList.add(NegativeActionButton(negativeActionTitle: negativeActionTitle , negativeAction: negativeAction,));
      }else {
        actionList.add(NegativeActionButton(negativeActionTitle: negativeActionTitle));
      }
    }

    // add the button to the action list if it doesn't equal null
    if(posActionTitle != null){
      if (actionList.isNotEmpty){
        actionList.add(const SizedBox(width: 20,));
      }
      if(posAction != null){
        actionList.add(PosActionButton(posActionTitle: posActionTitle , posAction: posAction,));
      }else{
        actionList.add(PosActionButton(posActionTitle: posActionTitle));
      }
    }


    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding:const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(1000)),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color:backgroundColor == MyTheme.purple ? MyTheme.offWhite : MyTheme.lightPurple),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: actionList,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }



  static showSuccessMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  }) {

    List<Widget> actionList = [];

    // add the button to the action list if it doesn't equal null
    if(negativeActionTitle != null){
      if(negativeAction != null){
        actionList.add(NegativeActionButton(negativeActionTitle: negativeActionTitle , negativeAction: negativeAction,));
      }else {
        actionList.add(NegativeActionButton(negativeActionTitle: negativeActionTitle));
      }
    }

    // add the button to the action list if it doesn't equal null
    if(posActionTitle != null){
      if (actionList.isNotEmpty){
        actionList.add(const SizedBox(width: 20,));
      }
      if(posAction != null){
        actionList.add(PosActionButton(posActionTitle: posActionTitle , posAction: posAction,));
      }else{
        actionList.add(PosActionButton(posActionTitle: posActionTitle));
      }
    }


    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:const EdgeInsets.all(20),
                    padding:const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)),
                    child:const Icon(
                      EvaIcons.checkmarkCircle,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color:backgroundColor == MyTheme.purple ? MyTheme.offWhite : MyTheme.lightPurple),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: actionList,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }

  static showQuestionMessage({
    required BuildContext context,
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
    required Color backgroundColor
  }) {

    List<Widget> actionList = [];

    // add the button to the action list if it doesn't equal null
    if(negativeActionTitle != null){
      if(negativeAction != null){
        actionList.add(NegativeActionButton(negativeActionTitle: negativeActionTitle , negativeAction: negativeAction,));
      }else {
        actionList.add(NegativeActionButton(negativeActionTitle: negativeActionTitle));
      }
    }

    // add the button to the action list if it doesn't equal null
    if(posActionTitle != null){
      if (actionList.isNotEmpty){
        actionList.add(const SizedBox(width: 20,));
      }
      if(posAction != null){
        actionList.add(PosActionButton(posActionTitle: posActionTitle , posAction: posAction,));
      }else{
        actionList.add(PosActionButton(posActionTitle: posActionTitle));
      }
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:const EdgeInsets.all(20),
                    padding:const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: MyTheme.lightPurple,
                        borderRadius: BorderRadius.circular(100)),
                    child:const Icon(
                      EvaIcons.questionMark,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color:backgroundColor == MyTheme.purple ? MyTheme.offWhite : MyTheme.lightPurple),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: actionList,
                ),
              )
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.7),
        barrierDismissible: false);
  }
}
