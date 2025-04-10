import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildActionItem({
  required IconData icon,
  required String label,
  required Color bgColor,
  Color? iconColor,
  Widget? overlayIcon,
  required double iconSize,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: iconSize,
            backgroundColor: bgColor,
            child: Icon(icon, color: iconColor ?? Colors.black, size: iconSize),
          ),
          if (overlayIcon != null)
            Positioned(
              bottom: 8,
              right: 8,
              child: overlayIcon,
            ),
        ],
      ),
      const SizedBox(height: 8),
      Text(label, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
    ],
  );
}
