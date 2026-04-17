import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/venues/view/menu/menu_category_item_view.dart';

import '../../bloc/venue/venue_menu_list_bloc.dart';
import '../../bloc/venue/venue_menu_list_state.dart';

class MenuBookingSelectorView extends StatefulWidget {
  const MenuBookingSelectorView({super.key});

  @override
  State<MenuBookingSelectorView> createState() => _MenuBookingSelectorViewState();
}

class _MenuBookingSelectorViewState extends State<MenuBookingSelectorView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
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
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выбор меню',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Внутри категорий находятится само меню',
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
              SizedBox(height: 20),
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
                        style: TextStyle(color: Color(0xFF888888), fontSize: 15),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(57,194,125, 1)
                              )
                          ),
                          prefixIcon: Icon(Icons.search, color: Color.fromRGBO(57,194,125, 1), size: 20),
                          hintText: 'Поиск категории ',
                          hintStyle: TextStyle(color: Color(0xFF888888), fontSize: 15),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              BlocBuilder<VenueMenuListBloc, VenueMenuListState>(
                bloc: getIt<VenueMenuListBloc>(),
                builder: (context, state){
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8), child: SizedBox()),
                      itemBuilder: (context, index) {
                        final category = state.items[index];
                        return MenuCategoryItemView(category: category);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
