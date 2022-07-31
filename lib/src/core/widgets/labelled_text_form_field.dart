import 'package:flutter/material.dart';

class LabelledTextFormField extends StatelessWidget {
  static const double vertPad = 16;
  static const double horzPad = 16;

  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?) validator;
  final Key labelKey;
  final Key inputKey;

  const LabelledTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.validator,
    required this.labelKey,
    required this.inputKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(horzPad, vertPad, horzPad, 0),
          child: Text(
              key: labelKey,
              label,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(horzPad, 0, horzPad, vertPad),
          child: TextFormField(
            key: inputKey,
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
