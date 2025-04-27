import 'package:flutter/cupertino.dart';

class SettingItem {
  final IconData icon;
  final String title;
  final Color color;
  final bool isLogout;

  SettingItem({
    required this.icon,
    required this.title,
    required this.color,
    this.isLogout = false,
  });
}
