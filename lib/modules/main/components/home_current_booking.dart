
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/booking/components/next_event_card_empty.dart';
import 'package:tennisapp/modules/booking/components/next_event_card_failure.dart';
import 'package:tennisapp/modules/venues/venues.dart';

import '../../booking/booking.dart';


class HomeCurrentBooking extends StatefulWidget{
  const HomeCurrentBooking({super.key});

  @override
  State<StatefulWidget> createState() => _HomeCurrentBookingState();
}
class _HomeCurrentBookingState extends State<HomeCurrentBooking>{

  @override
  void initState() {
    super.initState();

    getIt.registerLazySingleton<NextEventBloc>(() => NextEventBloc());

    getIt<NextEventBloc>().add(NextEventOnInitializedEvent());
  }

  @override
  void dispose() {
    getIt<NextEventBloc>().close();
    getIt.unregister<NextEventBloc>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(bottom: 100),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(26))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrentBookingListView())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Мои брони',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_outlined)
              ],
            )
          ),
          Text('Твоя ближайшая бронь'),

          BlocBuilder<NextEventBloc, NextEventState>(
            bloc: getIt<NextEventBloc>(),
            builder: (context, state) {

              if(state.status == NextEventStatus.loading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(state.status == NextEventStatus.success){
                if(state.nextEvent != null) {
                  return NextEventCard(nextEvent: state.nextEvent!);
                } else {
                  return NextEventCardEmpty();
                }
              }
              else if (state.status == NextEventStatus.failure){
                return NextEventCardFailure();
              }

              return NextEventCardEmpty();
            },
          ),
        ],
      ),
    );
  }
}