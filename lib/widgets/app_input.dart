import 'package:flutter/material.dart';
import 'package:monitor_ambiente/constants/app_colors.dart';

class AppInput extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;

  const AppInput({
    super.key,
    required this.title,
    this.controller,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late bool _obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: TextStyle(
          color: AppColors.primaryText
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16)
          ),
        ),
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: AppColors.secondaryText) : null,
        suffixIcon: widget.obscureText ? IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.secondaryText,
          ),
        ) : null,
      ),
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
    );
  }
}
