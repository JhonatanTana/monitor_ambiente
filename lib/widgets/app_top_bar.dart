import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitor_ambiente/blocs/sensor/sensor_cubit.dart';
import 'package:monitor_ambiente/services/auth_service.dart';
import 'package:monitor_ambiente/routes/app_router.dart';
import '../constants/app_colors.dart';

class AppTopBar extends StatefulWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  State<AppTopBar> createState() => _AppTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppTopBarState extends State<AppTopBar> {
  final AuthService _service = AuthService();

  String _initialLetters(String name) {
    String response = "";
    try {
      response = name
          .trim()
          .split(RegExp(r'\s+'))
          .take(2)
          .map((w) => w.isNotEmpty ? w[0].toUpperCase() : "")
          .join();
    } catch (_) {
      response = "";
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _service.userChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;
        final userName = user?.displayName ?? user?.email ?? "Usuário";

        return AppBar(
          backgroundColor: Colors.transparent,
          title: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.profileScreen);
            },
            child: Row(
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
                      _initialLetters(userName),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Bem Vindo,",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText
                      ),
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                final cubit = context.read<SensorCubit>();
                cubit.fetchMeasures(filter: cubit.state.filter);
              },
              icon: Icon(Icons.refresh, color: AppColors.primaryText),
            ),
          ],
        );
      },
    );
  }
}
