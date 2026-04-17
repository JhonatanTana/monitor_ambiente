import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/firebase_options.dart';
import 'package:monitor_ambiente/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splashScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}