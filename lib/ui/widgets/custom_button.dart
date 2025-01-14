import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final double height;
  final double width;
  final String text;
  final void Function()? onClick;
  const CustomButton({required this.height, required this.width, required this.text, this.onClick, super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: OutlinedButton(
            onPressed: onClick,
            style: ButtonStyle(
              side: WidgetStateProperty.all(BorderSide(color:Theme.of(context).colorScheme.primary)),
            ) ,
            child:Text(text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800
            ),
            ),
        ),
      ),
    );
  }

}