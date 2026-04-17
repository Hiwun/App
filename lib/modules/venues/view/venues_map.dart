
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as map;
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';

import '../bloc/venue/venue_list_map_bloc.dart';
import '../bloc/venue/venue_list_map_events.dart';
import '../bloc/venue/venue_list_map_state.dart';

class VenuesMap extends StatefulWidget {
  const VenuesMap({super.key});

  @override
  State<VenuesMap> createState() => _VenuesMapState();
}

class _VenuesMapState extends State<VenuesMap> with AutomaticKeepAliveClientMixin{
  late final AppLifecycleListener _lifecycleListener;

  map.MapWindow? _mapWindow;
  bool _isMapkitActive = false;

  late final VenueListMapBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  static const _loadMoreThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc = VenueListMapBloc();
    // сразу диспатчим initial
    _bloc.add(OnVenueListMapInitialEvent());

    _scrollController.addListener(_onScroll);

    _startMapkit();

    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _startMapkit();
        _setMapTheme();
      },
      onInactive: () {
        _stopMapkit();
      },
    );

  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bloc.close(); // важно закрыть bloc

    _stopMapkit();
    _lifecycleListener.dispose();
    //widget.onMapDispose?.call();

    super.dispose();
  }

  void _onScroll() {
    final state =  _bloc.state;

    // если уже идёт подгрузка или больше нет данных — не триггерим
    if (state.isLoadingMore || !state.hasMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;

    if (maxScroll - current <= _loadMoreThreshold) {
      // reached threshold -> load more
      _bloc.add(OnVenueListMapLoadMoreEvent());
    }
  }

  void _showModalFilter () {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close_outlined, size: 20,)
                      ),
                      Text('Фильтры', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: (){

                          },
                          child: Text('Сбросить', style: TextStyle(color: Color.fromRGBO(57,194,125, 1)),)
                      )
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
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(57,194,125, 1)
                                  )
                              ),
                              prefixIcon: Icon(Icons.search, color: Color.fromRGBO(57,194,125, 1), size: 20),
                              hintText: 'Поиск',
                              hintStyle: TextStyle(color: Color(0xFF888888), fontSize: 15),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){

                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1)),
                        ),
                        child: Text(
                          'Применить',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context){
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          // Back button
                          if (Navigator.of(context).canPop() == true)
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
                          if (Navigator.of(context).canPop() == true)
                            SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Карта заведений',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Отобразили вам заведения на карте',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 42,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(57,194,125, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showModalFilter();
                              },
                              icon: Icon(Icons.filter_alt_outlined, color: Colors.white, size: 22),
                              padding: EdgeInsets.zero,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    BlocBuilder<VenueListMapBloc, VenueListMapState>(
                      builder: (context, state) {
                        return Expanded(
                          child: YandexMap(
                            onMapCreated: (mapWindow){
                              _mapWindow = mapWindow;
                              _mapWindow?.map.move(map.CameraPosition(
                                map.Point(latitude: 57.626559, longitude:39.893813),
                                zoom: 15.0,
                                azimuth: 0.0,
                                tilt: 0.0,
                              ));

                            },

                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }



  void _startMapkit() {
    if (!_isMapkitActive) {
      _isMapkitActive = true;
      mapkit.onStart();
    }
  }

  void _stopMapkit() {
    if (_isMapkitActive) {
      _isMapkitActive = false;
      mapkit.onStop();
    }
  }

  // void _onMapCreated(map.MapWindow window) {
  //
  //   window.let((it) {
  //     //widget.onMapCreated(window);
  //     _mapWindow = it;
  //
  //     it.map.logo.setAlignment(
  //       const map.LogoAlignment(
  //         map.LogoHorizontalAlignment.Left,
  //         map.LogoVerticalAlignment.Bottom,
  //       ),
  //     );
  //   });
  //
  //   _setMapTheme();
  // }

  void _setMapTheme() {
    _mapWindow?.map.nightModeEnabled =
        Theme.of(context).brightness == Brightness.dark;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

}
