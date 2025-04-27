import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String title;
  final bool selected;
  final ontab;

  const LanguageButton({
    required this.title,
    required this.ontab,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        selected ? Icons.check_circle : Icons.language,
        color: selected ? Colors.green : null,
      ),
      label: Text(title, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: selected ? Colors.green.shade100 : null,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: ontab,
    );
  }
}
