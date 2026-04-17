
import 'package:flutter/material.dart';
import 'package:tennisapp/models/model.dart';

class ActivityItem extends StatefulWidget{
  final Activity activity;
  const ActivityItem({super.key, required this.activity});

  @override
  State<StatefulWidget> createState() => _ActivityItemState();

}
class _ActivityItemState extends State<ActivityItem>{

  _ActivityItemState(){
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    _containerWidth = size.width / pixelRatio * 0.9;

  }

  late final double _containerWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: _containerWidth,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 6,
                  children: [
                    Text(
                      "${widget.activity.type},",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Text(widget.activity.text),
              ],
            ),
          )
        ],
      ),
    );
  }
}