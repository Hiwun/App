import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_center_state.dart';
import 'package:tennisapp/modules/venues/venues.dart';

import '../../promo/bloc/promo_main_center_bloc.dart';
import '../../promo/bloc/promo_main_center_events.dart';
import 'horizontal_faq_main.dart';

class HomeInformation extends StatefulWidget{
  const HomeInformation({super.key});

  @override
  State<StatefulWidget> createState() => _HomeInformationState();
}

class _HomeInformationState extends State<HomeInformation>{

  _HomeInformationState(){
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    _imageContainerWidth = size.width / pixelRatio * 0.9;
  }

  late final PromoMainCenterBloc _bloc;


  void _showModalPromo (Promotion promo) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.6,
            expand: false, // Важно: запрещаем расширяться
            builder: (_, controller) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
                            errorBuilder: (context, error, stakeTrace){
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(22))
                                ),
                                color: Colors.grey[300],
                                height: 200,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              );
                            },
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(promo.description),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => BookingVenueView()
                              // ));
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
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  final CarouselController _controller = CarouselController();
  Timer? _timer;
  double _currentOffset = 0;

  @override
  void initState() {

    super.initState();

    _bloc = PromoMainCenterBloc();
    // сразу диспатчим initial
    _bloc.add(OnPromoMainCenterInitialEvent());

    _timer = Timer.periodic(Duration(seconds: 6), (Timer timer) {
      if(!_controller.hasClients){
        return;
      }
      // Вычисляем следующий offset
      double nextOffset = _currentOffset + _imageContainerWidth;

      // Если достигли конца - возвращаемся к началу
      if (nextOffset >= _bloc.state.items.length * _imageContainerWidth) {
        nextOffset = 0;
      }

      _controller.animateTo(
        nextOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );

      setState(() {
        _currentOffset = nextOffset;
      });
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _bloc.close();
    super.dispose();
  }
  late final double _imageContainerWidth;


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context){
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(26))
            ),
            child: Column(
              spacing: 12,
              children: [
                HorizontalFAQMain(),
                SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: ClipRect(
                    child: BlocBuilder<PromoMainCenterBloc, PromoMainCenterState>(
                      builder: (context, state){

                        if(state.status == PromoMainCenterStatus.loading){
                          return Center(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return CarouselView(
                          onTap: (index){
                            _showModalPromo(state.items[index]);
                          },
                          controller: _controller,
                          itemExtent: double.infinity,//MediaQuery.of(context).size.width,
                          itemSnapping: true,

                          children: state.items.map((url){
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(57,194,125, 1)
                                    ),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        // if(!getIt.isRegistered<PlayBloc>()){
                        //   getIt.registerLazySingleton(() => PlayBloc());
                        //   getIt<PlayBloc>().add(PlaySelectTypeEvent(PlaySelectType.court));
                        // }
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => VenueList()));
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}