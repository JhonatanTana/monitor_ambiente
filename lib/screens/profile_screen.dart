import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';
import 'package:monitor_ambiente/services/auth_service.dart';
import 'package:monitor_ambiente/widgets/app_alert_dialog.dart';
import 'package:monitor_ambiente/widgets/app_button.dart';
import 'package:monitor_ambiente/widgets/app_input.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  String _username = "";
  final AuthService _service = AuthService();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void getUsername() async {
    try {
      setState(() {
        isLoading = true;
      });

      String? response = await _service.getUserName();

      if (response != null) {
        setState(() {
          isLoading = false;
          _username = response;
          _usernameController.text = _username;
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      AppAlertDialog.show(
        title: "Erro",
        content: "Houve um erro ao recuperar o nome de usuário. \n Erro: ${e.toString()}",
        buttonText: "Ok",
        isError: true
      );
    }
  }

  void updateUsername(String username) async {
    try {
      setState(() {
        isLoading = true;
      });

      String? response = await _service.updateUserName(username);

      if (response != null) {
        setState(() {
          isLoading = false;
          _username = response;
          _usernameController.text = _username;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      AppAlertDialog.show(
          title: "Erro",
          content: "Houve um erro ao atualizar o nome de usuário. \n Erro: ${e.toString()}",
          buttonText: "Ok",
          isError: true
      );
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "??";
    return name
        .trim()
        .split(RegExp(r'\s+'))
        .take(2)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : "")
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  spacing: 16,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 96,
                        child: Text(
                          _getInitials(_username),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 96,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                    ),

                    AppInput(
                      title: "Nome",
                      controller: _usernameController,
                    ),
                  ],
                )
              ),

              AppButton(
                title: "Salvar",
                isLoading: isLoading,
                onPressed: () => updateUsername(_usernameController.text),
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }
}
