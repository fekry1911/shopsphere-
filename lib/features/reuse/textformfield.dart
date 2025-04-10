import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormCustom extends StatelessWidget {
   TextFormCustom({super.key,required this.Valid,required this.nameController,required this.HintText,required this.IconPrefix,required this.obscureTextl});
  TextEditingController nameController;
  String HintText;
  Icon IconPrefix;
  String Valid;
  bool obscureTextl;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      obscureText: obscureTextl,
      decoration: InputDecoration(
        hintText: HintText,
        hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: IconPrefix
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Valid;
        }
        return null;
      },
    );
  }
}
