import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final void Function(String) onChanged;
  final String initialValue;
  final String labelText;

  const TextFieldWidget({
    Key? key,
    required this.onChanged,
    required this.initialValue,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
