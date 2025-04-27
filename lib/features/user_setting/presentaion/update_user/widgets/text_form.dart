import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BuildTextField({
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  required TextEditingController textcontrol
}) {
  return TextFormField(
    controller: textcontrol,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    keyboardType: keyboardType,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $label';
      }
      return null;
    },
  );
}