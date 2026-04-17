import 'package:flutter/material.dart';
import 'package:tennisapp/components/image/image.dart';
import 'package:tennisapp/modules/play/bloc/play/play_bloc.dart';
import 'package:tennisapp/modules/play/bloc/play/play_event.dart';
import 'package:tennisapp/modules/play/view/select_booking_confirm_screen.dart';
import 'package:tennisapp/modules/play/view/select_time_booking_screen.dart';

import '../../../di/locator.dart';

class SelectPlayCourtCard extends StatefulWidget{
  const SelectPlayCourtCard({super.key});


  @override
  State<StatefulWidget> createState() => _SelectPlayCourtCardState();

}
class _SelectPlayCourtCardState extends State<SelectPlayCourtCard>{

  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  final List<String> imageUrls = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
  ];
  _SelectPlayCourtCardState(){
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    _imageContainerWidth = size.width / pixelRatio * 0.9;
  }

  @override
  void initState() {
    _controller.addListener(_onScroll);

    super.initState();
  }
  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }
  late final double _imageContainerWidth;

  void _onScroll(){
    final position = _controller.position;
    if (position.hasPixels) {
      final index = (position.pixels / _imageContainerWidth).round();
      if (index != _currentIndex) {
        setState(() {
          _currentIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        String? fromRoute = ModalRoute.of(context)?.settings.arguments as String?;
        //getIt<PlayBloc>().add(PlaySelectCourtEvent(Court(id: 1, guid: 'guid', createdAt: DateTime.now(), updatedAt: DateTime.now(), userId: 1, name: 'name', address: 'address', surfaceType: 'surfaceType', autoAcceptBookingRequest: true, isIndoor: true)));
        if(fromRoute != null && fromRoute == 'select_time'){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectBookingConfirmScreen()
          ));
        }
        else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectTimeBookingScreen()
          ));
        }


      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: _imageContainerWidth,
            child: CarouselView(
              onTap: (index){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FullScreenImages(images: imageUrls, initialIndex: index)
                ));
              },
              controller: _controller,
              itemExtent: _imageContainerWidth,//MediaQuery.of(context).size.width,
              itemSnapping: true,
              children: imageUrls.map((url){
                return Image.network(
                  url,
                  errorBuilder: (context, error, stakeTrace){
                    return Container(
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
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imageUrls.length, (index){
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.green
                        : Colors.grey.shade400
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: _imageContainerWidth,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 6,
                  children: [
                    Text(
                      "Корт №7,",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Свободы 17",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Text("Ближайший от вас"),
                Wrap(
                  runSpacing: 4,
                  spacing: 4,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.fromBorderSide(
                            BorderSide(
                                width: 1,
                                color: Colors.lightGreen
                            )
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          "Резиновое покрытие",
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.fromBorderSide(
                            BorderSide(
                                width: 1,
                                color: Colors.lightGreen
                            )
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          "Крытый корт",
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.fromBorderSide(
                            BorderSide(
                                width: 1,
                                color: Colors.lightGreen
                            )
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          "Парковка",
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.fromBorderSide(
                            BorderSide(
                                width: 1,
                                color: Colors.lightGreen
                            )
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          "Парковка",
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.fromBorderSide(
                            BorderSide(
                                width: 1,
                                color: Colors.lightGreen
                            )
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          "Парковка",
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}