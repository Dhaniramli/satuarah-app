import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class TextFormWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const TextFormWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLines,
    this.controller,
    required this.obscureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textBlackDuaStyle.copyWith(
            fontSize: 12,
            fontWeight: regular,
          ),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.94),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
