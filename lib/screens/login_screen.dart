import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/routes/app_router.dart';
import 'package:monitor_ambiente/widgets/app_button.dart';
import 'package:monitor_ambiente/widgets/app_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void login() {
    Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                      isLoading: false,
                      onPressed: () => login(),
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
