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
      elevation: 1.5,
      color: AppColors.onBackground,
      child: SizedBox(
        width: double.infinity,
        height: 150,
      ),
    );
  }
}
