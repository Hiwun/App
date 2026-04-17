import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/components/dev/dev.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/main/components/horizontal_faq_item.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_top_bloc.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_top_events.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_top_state.dart';

class HorizontalFAQMain extends StatefulWidget{
  const HorizontalFAQMain({super.key});

  @override
  State<StatefulWidget> createState() => _HorizontalFAQMainState();
}

class _HorizontalFAQMainState extends State<HorizontalFAQMain>{

  late final PromoMainTopBloc _bloc;

  List<Color> colors = [
    Color.fromRGBO(3, 135, 52, 1),
    Color.fromRGBO(112, 177, 123, 1),
    Color.fromRGBO(182, 207, 177, 1),
    Color.fromRGBO(3, 61, 37, 1)
  ];

  @override
  void initState() {
    super.initState();
    _bloc = PromoMainTopBloc();
    // сразу диспатчим initial
    _bloc.add(OnPromoMainTopInitialEvent());

  }

  @override
  void dispose() {
    _bloc.close(); // важно закрыть bloc
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context){
          return BlocBuilder<PromoMainTopBloc, PromoMainTopState>(
            builder: (context, state){

              if(state.status == PromoMainTopStatus.loading){
                return Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Row(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: state.items.map((promo) {
                  int i = -1;
                  i++;

                  return HorizontalFAQItem(
                    text1: promo.firstTitle,
                    text2: promo.twoTitle,
                    text3: promo.threeTitle,
                    color: colors[i],
                    onTap: () => _showModalPromo(promo),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}