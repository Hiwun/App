import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalFAQItem extends StatelessWidget{
  final String text1;
  final String text2;
  final String text3;
  final Color color;
  final VoidCallback onTap;
  const HorizontalFAQItem({super.key, required this.text1, required this.text2, required this.text3, required this.color, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return
      CupertinoButton(
        minSize: 0,
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child:
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                  color: color,
                  width: 1.5
              )
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(8)),

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),
                ),
                Text(
                  text3,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}