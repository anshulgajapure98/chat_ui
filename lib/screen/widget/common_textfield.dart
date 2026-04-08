import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int? maxLength;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool filled;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.onTap,
    this.contentPadding,
    this.border,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.filled = false,
    this.errorStyle,
    this.errorMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      style: textStyle,

      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle,
        filled: filled,
        fillColor: fillColor,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        errorStyle: errorStyle,
        errorMaxLines: errorMaxLines,

        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

        border:
            border ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        enabledBorder:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),

        focusedBorder:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
