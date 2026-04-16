import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTopBar extends StatefulWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  State<AppTopBar> createState() => _AppTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppTopBarState extends State<AppTopBar> {
  bool isLoading = false;

  // TODO: Implementar o shimmer;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        spacing: 8,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text(
                "JS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bem Vindo,",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                "Jhonatan Souza",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications, color: Colors.amber),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.refresh, color: AppColors.primary),
        ),
      ],
    );
  }
}
