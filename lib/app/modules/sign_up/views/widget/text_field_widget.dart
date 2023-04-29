import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textGrayStyle.copyWith(
            fontSize: 12,
            fontWeight: regular,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.94))),
        ),
      ],
    );
  }
}
