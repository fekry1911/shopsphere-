import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/cubit/appCubit/appCubit.dart';
import '../../../../core/theme/colors.dart';

Widget BuildPaymentOption(BuildContext context, String label,icon , color,cubit) {
  final selected = cubit.selectedPaymentMethod;

  return GestureDetector(
    onTap: () => cubit.setPaymentMethod(label),
    child: Card(
      elevation: 4,
      color: selected == label ? Colors.purple[100] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon,color: color,),
        trailing: Radio<String>(
          value: label,
          groupValue: selected,
          onChanged: (value) => cubit.setPaymentMethod(value!),
          activeColor: maincolor,
        ),
        title: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    ),
  );
}
