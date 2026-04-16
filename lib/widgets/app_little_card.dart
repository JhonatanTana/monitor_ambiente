import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppLittleCard extends StatefulWidget {
  const AppLittleCard({super.key});

  @override
  State<AppLittleCard> createState() => _AppLittleCardState();
}

class _AppLittleCardState extends State<AppLittleCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
