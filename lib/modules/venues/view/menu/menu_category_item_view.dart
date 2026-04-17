import 'package:flutter/material.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/view/menu/menu_items_view.dart';

class MenuCategoryItemView extends StatefulWidget {

  final MenuCategory category;

  const MenuCategoryItemView({super.key, required this.category});

  @override
  State<MenuCategoryItemView> createState() => _MenuCategoryItemViewState();
}

class _MenuCategoryItemViewState extends State<MenuCategoryItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuItemsView(category: widget.category,)
        ));
      },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Colors.grey.shade300,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.category.name, style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(widget.category.description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600),),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_outlined, size: 15)
          ],
        ),
      ),
    );
  }
}
