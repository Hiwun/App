import 'package:flutter/material.dart';

class InfoField extends StatelessWidget{
  final String title;
  final String value;
  final EdgeInsets? padding;

  const InfoField({super.key, required this.title, this.padding = const EdgeInsets.symmetric(horizontal: 25), required this.value});
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(),
          child: Text(
            value,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}