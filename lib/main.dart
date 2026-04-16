import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splashScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}