import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

void ShowToast({required context,required icon,required message}){
  CherryToast(

      icon:  icon,

      themeColor:  maincolor,

      animationType: AnimationType.fromBottom,



      description:  Text(message, style:  TextStyle(color:  Colors.black)),

      toastPosition:  Position.bottom,

      animationDuration:  Duration(milliseconds:  1000),

      autoDismiss:  true

  ).show(context);

}