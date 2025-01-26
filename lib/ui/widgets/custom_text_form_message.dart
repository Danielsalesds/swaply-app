import 'package:flutter/material.dart';

class CustomTextFormMessage extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validateFunction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextFormMessage(
      {super.key,
      required this.labelText,
      this.validateFunction,
      this.controller,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validateFunction,
        style: const TextStyle(color: Colors.black), // Texto preto
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black), // Texto do label preto
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey), // Borda cinza padrão
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey), // Borda cinza
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFFA726)), // Laranja quando em foco
            borderRadius: BorderRadius.circular(5),
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
        ),
      ),
    );
  }
}
