import 'package:flutter/material.dart';
import 'package:monitor_ambiente/main.dart';

import '../constants/app_colors.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final Color iconColor;
  final IconData icon;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.buttonText = "OK",
    this.iconColor = Colors.orange,
    this.icon = Icons.warning_amber_rounded,
  });

  static Future<void> show({
    required String title,
    required String content,
    String buttonText = "OK",
    bool isError = false,
  }) {
    return showDialog<void>(
      context: navigatorKey.currentContext!,
      builder: (context) => AppAlertDialog(
        title: title,
        content: content,
        buttonText: buttonText,
        iconColor: isError ? AppColors.primary : Colors.orange,
        icon: isError ? Icons.error_outline : Icons.warning_amber_rounded,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      title: Column(
        spacing: 8,
        children: [
          Icon(icon, color: iconColor, size: 56),

          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Arial'
            ),
          ),
        ],
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Arial',
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: iconColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white, fontFamily: 'Arial'),
            ),
          ),
        ),
      ],
    );
  }
}