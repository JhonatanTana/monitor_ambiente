import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/routes/app_router.dart';
import 'package:monitor_ambiente/services/auth_service.dart';
import 'package:monitor_ambiente/widgets/app_button.dart';
import 'package:monitor_ambiente/widgets/app_input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _service = AuthService();
  final _storage = const FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool isLoading;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _init() async {
    isLoading = false;
    emailController.text = await _storage.read(key: "email") ?? "";
    passwordController.text = await _storage.read(key: "password") ?? "";
  }

  void _saveCredentials(String email, String password) {
    _storage.write(key: "email", value: email);
    _storage.write(key: "password", value: password);
  }

  void login(String email, String password) async {

    setState(() {
      isLoading = true;
    });

    var response = await _service.login(email, password);

    if (response == null) {
      _saveCredentials(email, password);

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacementNamed(
        navigatorKey.currentContext!,
        AppRouter.homeScreen,
      );
    } else {

      setState(() {
        isLoading = false;
      });

      showDialog(
        context: navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
          title: const Text("Erro"),
          content: Text(response),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 150,
                ),

                Column(
                  spacing: 8,
                  children: [

                    AppInput(
                      title: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                    ),

                    AppInput(
                      title: "Senha",
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),

                    AppButton(
                      title: "Entrar",
                      isLoading: isLoading,
                      onPressed: () => login(emailController.text, passwordController.text),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
