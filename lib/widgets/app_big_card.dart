import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppBigCard extends StatefulWidget {
  const AppBigCard({super.key});

  @override
  State<AppBigCard> createState() => _AppBigCardState();
}

class _AppBigCardState extends State<AppBigCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.onBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 150,
      ),
    );
  }
}
