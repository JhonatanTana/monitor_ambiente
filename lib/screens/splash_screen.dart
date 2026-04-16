import 'package:flutter/material.dart';
import 'package:monitor_ambiente/routes/app_router.dart';

import '../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    waitAndNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
                "assets/images/logo.png",
              width: 150,
            ),

            CircularProgressIndicator(
              color: AppColors.primary,
            )
          ],
        ),
      )
    );
  }

  void waitAndNextScreen() {
    Future.delayed(Duration(milliseconds: 2300)).then((value) {
        Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
      },
    );
  }
}