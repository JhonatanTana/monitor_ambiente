import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;

  const AppButton({super.key, required this.title, required this.isLoading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          textStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLoading,
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.onPrimary,
                ),
              ),
            ),
            Text(isLoading ? "Carregando" : "Entrar"),
          ],
        ),
      ),
    );
  }
}
