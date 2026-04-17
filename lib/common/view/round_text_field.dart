import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundTitleTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;

  const RoundTitleTextField(
      {super.key,
        required this.title,
        required this.hintText,
        this.controller,
        this.keyboardType,
        this.bgColor,
        this.left,
        this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: bgColor ?? Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
              ),
              child: left!,
            ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 12,),
                  alignment: Alignment.topLeft,
                  child: CupertinoTextField(
                    autocorrect: false,
                    controller: controller,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 10, left: 14),
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}