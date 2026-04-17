import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_top_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_menu_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_menu_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_events.dart';
import 'package:tennisapp/modules/venues/view/booking_venue_view.dart';
import 'package:tennisapp/modules/venues/view/hall/hall_tables_available_info_view.dart';
import 'package:tennisapp/utils/utils.dart';
import 'hall/hall_screen_info.dart';

class VenueProfileView extends StatefulWidget {
  final Venue venue;
  const VenueProfileView({super.key, required this.venue});

  @override
  State<VenueProfileView> createState() => _VenueProfileViewState();
}

class _VenueProfileViewState extends State<VenueProfileView> {

  late final VenueHallListBloc _hallListBloc;
  late final VenueTablesAvailabilityListBloc _tablesAvailabilityListBloc;
  late final VenueMenuListBloc _menuListBloc;

  @override
  void initState() {
    super.initState();



    _hallListBloc = VenueHallListBloc(widget.venue.guid)..add(OnVenueHallListInitialEvent(venueGUID: widget.venue.guid));
    _tablesAvailabilityListBloc = VenueTablesAvailabilityListBloc(venueGUID: widget.venue.guid)..add(OnVenueTablesAvailabilityListInitialEvent(venueGUID: widget.venue.guid));
    _menuListBloc = VenueMenuListBloc(venueGUID: widget.venue.guid)..add(OnVenueMenuListInitialEvent(venueGUID: widget.venue.guid));

    if (!getIt.isRegistered<VenueHallListBloc>()){
      getIt.registerLazySingleton(() => _hallListBloc);
    }
    if (!getIt.isRegistered<VenueTablesAvailabilityListBloc>()){
      getIt.registerLazySingleton(() => _tablesAvailabilityListBloc);
    }
    if (!getIt.isRegistered<VenueMenuListBloc>()){
      getIt.registerLazySingleton(() => _menuListBloc);
    }
  }

  @override
  void dispose() {
    _hallListBloc.close();
    _tablesAvailabilityListBloc.close();
    _menuListBloc.close();

    getIt.unregister<VenueHallListBloc>();
    getIt.unregister<VenueTablesAvailabilityListBloc>();
    getIt.unregister<VenueMenuListBloc>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _hallListBloc,
        ),
        BlocProvider.value(
          value: _tablesAvailabilityListBloc,
        ),
        BlocProvider.value(
          value: _menuListBloc,
        ),
      ],
      child: Builder(
        builder: (context){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.network(
                  widget.venue.images.isNotEmpty ? widget.venue.images.first : 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
                  width: media.width,
                  height: media.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: media.width,
                  height: media.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: media.width - 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Text(
                                        widget.venue.name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              IgnorePointer(
                                                ignoring: true,
                                                child: RatingBar.builder(
                                                  initialRating: widget.venue.rating,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 20,
                                                  itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {

                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Рейтинг заведения",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Работает сегодня",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "с ${DateFormat("HH:mm").format(widget.venue.openTime)} до ${DateFormat("HH:mm").format(widget.venue.closeTime)}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Text(
                                        "Адрес",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Text(
                                        widget.venue.shortAddress,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Text(
                                        "Описание",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Text(
                                        widget.venue.description,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Divider(
                                          color:
                                          Colors.black.withOpacity(0.4),
                                          height: 1,
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Text(
                                        "Теги заведения",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: Wrap(
                                        runSpacing: 6,
                                        spacing: 4,
                                        children: widget.venue.tags.map((tag) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                                border: Border.fromBorderSide(
                                                    BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(57,194,125, 1)
                                                    )
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                                child: Text(
                                                  tag,
                                                  style: TextStyle(
                                                      fontSize: 12
                                                  ),
                                                ),
                                              ),
                                            )
                                        ).toList(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => BookingVenueView(venue: widget.venue)
                                              ));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1)),
                                            ),
                                            child: Text(
                                              'Забронировать стол',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => HallPainterInfoScreen()
                                    ));
                                  },
                                  icon: Icon(Icons.map_outlined, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => HallTablesAvailableInfoView()
                                    ));
                                  },
                                  icon: Icon(Icons.list_alt_outlined, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}