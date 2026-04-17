import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_event.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_state.dart';

class MenuItemView extends StatefulWidget {

  final MenuItem item;

  const MenuItemView({super.key, required this.item});

  @override
  State<MenuItemView> createState() => _MenuItemViewState();
}

class _MenuItemViewState extends State<MenuItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // showModalBottomSheet(
        //     context: context,
        //     builder: (context) {
        //       return SizedBox(
        //         height: 400,
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
        //           ),
        //           child: Center(
        //             child: ElevatedButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 },
        //                 child: const Text('Закрыть')
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        // );
      },
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Colored top section
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                // White bottom section with text
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Item name
                      Text(
                        widget.item.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      // Item type
                      Text(
                        widget.item.type,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.item.price.toStringAsFixed(2)} ₽',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent.shade400,
                            ),
                          ),
                          BlocBuilder<BookingVenueBloc, BookingVenueState>(
                            bloc: getIt<BookingVenueBloc>(),
                            builder: (context, state){

                              BookingMenuItem bookingMenuItem;

                              if(state.menuItems.any((item) => item.menuItemGUID == widget.item.guid)){
                                bookingMenuItem = state.menuItems.firstWhere((item) => item.menuItemGUID == widget.item.guid);
                              } else {
                                bookingMenuItem = BookingMenuItem(
                                  menuItemGUID: widget.item.guid,
                                  bookingGUID: state.guid,
                                  type: widget.item.type,
                                  title: widget.item.name,
                                  price: widget.item.price,
                                  quantity: 0,
                                );
                              }


                              if(state.menuItems.isEmpty || bookingMenuItem.quantity == 0){
                                return SizedBox(
                                  height: 32,
                                  child: IconButton(
                                      iconSize: 16,
                                      style: ButtonStyle(
                                          minimumSize: const WidgetStatePropertyAll(Size(14, 14)),
                                          backgroundColor: const WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1))
                                      ),
                                      onPressed: () {
                                        final newBookingMenuItem = BookingMenuItem(
                                          menuItemGUID: widget.item.guid,
                                          bookingGUID: state.guid,
                                          type: widget.item.type,
                                          title: widget.item.name,
                                          price: widget.item.price,
                                          quantity: 1,
                                        );
                                        getIt<BookingVenueBloc>().add(OnBookingVenueUpdateEvent(menuItems: [...state.menuItems, newBookingMenuItem]));
                                      },
                                      icon: Icon(Icons.add_outlined, color: Colors.white,)
                                  ),
                                );
                              }

                              return Container(
                                height: 28,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Минус
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: IconButton(
                                        icon: Icon(Icons.remove, size: 16),
                                        padding: EdgeInsets.zero,
                                        onPressed: (){
                                          final newBookingItem = BookingMenuItem(
                                              bookingGUID: bookingMenuItem.bookingGUID,
                                              menuItemGUID: bookingMenuItem.menuItemGUID,
                                              type: bookingMenuItem.type,
                                              title: bookingMenuItem.title,
                                              price: bookingMenuItem.price,
                                              quantity: bookingMenuItem.quantity - 1
                                          );
                                          List<BookingMenuItem> newItems;

                                          if(newBookingItem.quantity > 0){
                                            newItems = [...state.menuItems.where((item) => item.menuItemGUID != bookingMenuItem.menuItemGUID), newBookingItem];
                                          } else {
                                            newItems = state.menuItems.where((item) => item.menuItemGUID != bookingMenuItem.menuItemGUID).toList();
                                          }

                                          getIt<BookingVenueBloc>().add(OnBookingVenueUpdateEvent(menuItems: newItems));
                                        },
                                        color: Colors.black ,
                                      ),
                                    ),

                                    // Количество
                                    Text(
                                      bookingMenuItem.quantity.toString(),
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),

                                    // Плюс
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: IconButton(
                                          icon: Icon(Icons.add, size: 16),
                                          padding: EdgeInsets.zero,
                                          onPressed: (){
                                            final newBookingItem = BookingMenuItem(
                                                bookingGUID: bookingMenuItem.bookingGUID,
                                                menuItemGUID: bookingMenuItem.menuItemGUID,
                                                type: bookingMenuItem.type,
                                                title: bookingMenuItem.title,
                                                price: bookingMenuItem.price,
                                                quantity: bookingMenuItem.quantity + 1
                                            );
                                            final newItems = [...state.menuItems.where((item) => item.menuItemGUID != bookingMenuItem.menuItemGUID), newBookingItem];
                                            getIt<BookingVenueBloc>().add(OnBookingVenueUpdateEvent(menuItems: newItems));
                                          }
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),

            // Discount badge
            if (widget.item.discount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '-${widget.item.discount.toString()}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
