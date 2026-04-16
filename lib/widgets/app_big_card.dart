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
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1.5,
        color: AppColors.onBackground,
        child: SizedBox(
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
