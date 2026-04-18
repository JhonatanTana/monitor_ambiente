import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitor_ambiente/blocs/sensor/sensor_cubit.dart';
import 'package:monitor_ambiente/services/auth_service.dart';
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
  bool isLoading = false;
  late String _userName = "";

  Future<void> _getUserName() async {
    String? userName = await _service.getUserName();
    String email = await _service.getEmail();

    setState(() {
      _userName = userName ?? email;
    });
  }

  String _initialLetters() {
    late String? response = "";
    try {
      response = _userName
          .trim()
          .split(RegExp(r'\s+'))
          .take(2)
          .map((w) => w[0].toUpperCase())
          .join();
    }
    catch(_) {
      response = "";
    }
    return response;
  }

  @override
  void initState() {
    _getUserName();
    super.initState();
  }

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
                _initialLetters(),
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
                _userName,
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
      actions: [
        /*IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications, color: Colors.amber),
        ),*/
        IconButton(
          onPressed: () {
            final cubit = context.read<SensorCubit>();
            cubit.fetchMeasures(filter: cubit.state.filter);
          },
          icon: Icon(Icons.refresh, color: AppColors.primaryText),
        ),
      ],
    );
  }
}
