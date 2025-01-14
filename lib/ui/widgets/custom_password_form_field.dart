import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validateFunction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomPasswordFormField({
    super.key,
    required this.labelText,
    this.validateFunction,
    this.controller,
    this.keyboardType,
  });

  @override
  State<CustomPasswordFormField> createState() => _CustomPassordFormFieldState();
}

class _CustomPassordFormFieldState extends State<CustomPasswordFormField> {
  late bool obscured = true;

  @override
  void initState() {
    super.initState();
    obscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validateFunction,
        obscureText: obscured,
          style:TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.secondary,
          ),
        decoration: InputDecoration(
            suffixIconColor:  Theme.of(context).colorScheme.primary,
            suffixIcon: GestureDetector(
              onTap: () => {
                setState(() {
                  obscured = !obscured;
                })
              },
              child: obscured
                  ? const Icon(Icons.remove_red_eye_rounded,)
                  : const Icon(Icons.remove_red_eye_outlined),
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 22,
                fontWeight: FontWeight.w500
            ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(15)
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
        ),
      ),
    );
  }
}