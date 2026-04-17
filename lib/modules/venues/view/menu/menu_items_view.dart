import 'package:flutter/material.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/view/menu/menu_item_view.dart';

class MenuItemsView extends StatefulWidget {

  final MenuCategory category;

  const MenuItemsView({super.key, required this.category});

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and header
              Row(
                children: [
                  // Back button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.grey[700], size: 20),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.category.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(57,194,125, 1)
                              )
                          ),
                          prefixIcon: Icon(Icons.search, color: Color.fromRGBO(57,194,125, 1), size: 20),
                          hintText: 'Поиск ',
                          hintStyle: TextStyle(color: Color(0xFF888888), fontSize: 15),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
              // Vegetables grid
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Wrap(
                      spacing: 16, // горизонтальное расстояние
                      runSpacing: 16, // вертикальное расстояние
                      children: widget.category.menuItems.map((item) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width - 48) / 2, // расчет ширины
                          child: MenuItemView(item: item),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
