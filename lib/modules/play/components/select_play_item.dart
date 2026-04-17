
import 'package:flutter/material.dart';

class SelectPlayItem extends StatelessWidget{
  final String label;
  final Color color;
  final AssetImage image;
  final VoidCallback onTap;
  const SelectPlayItem({super.key, required this.label, required this.color, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          border: Border.all(
            color: color,
            width: 1,
          )
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: color
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 8,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ВЫБРАТЬ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Text(
                        label,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                  Image(
                    image: image,
                    height: 100,
                    width: 190,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}