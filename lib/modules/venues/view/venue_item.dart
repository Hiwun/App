
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tennisapp/components/image/image.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/view/venue_profile.dart';

class VenueItem extends StatefulWidget{
  final Venue venue;
  const VenueItem({super.key, required this.venue});


  @override
  State<StatefulWidget> createState() => _VenueItemState();

}
class _VenueItemState extends State<VenueItem>{

  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  final List<String> placeholderImageUrls = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png',
  ];
  _VenueItemState(){
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
        // String? fromRoute = ModalRoute.of(context)?.settings.arguments as String?;
        // getIt<PlayBloc>().add(PlaySelectCourtEvent(Court(id: 1, guid: 'guid', createdAt: DateTime.now(), updatedAt: DateTime.now(), userId: 1, name: 'name', address: 'address', surfaceType: 'surfaceType', autoAcceptBookingRequest: true, isIndoor: true)));
        // if(fromRoute != null && fromRoute == 'select_time'){
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => SelectBookingConfirmScreen()
        //   ));
        // }
        // else {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => SelectTimeBookingScreen()
        //   ));
        // }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VenueProfileView(venue: widget.venue)
        ));


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
                    builder: (context) => FullScreenImages(images: widget.venue.images.isNotEmpty ? widget.venue.images : placeholderImageUrls, initialIndex: index)
                ));
              },
              controller: _controller,
              itemExtent: _imageContainerWidth,//MediaQuery.of(context).size.width,
              itemSnapping: true,
              children: (widget.venue.images.isNotEmpty ? widget.venue.images : placeholderImageUrls).map((url){
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
            children: List.generate((widget.venue.images.isNotEmpty ? widget.venue.images : placeholderImageUrls).length, (index){
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? CupertinoColors.systemBlue
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
                      "${widget.venue.name},",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.venue.shortAddress,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Row(
                  spacing: 3,
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
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {

                        },
                      ),
                    ),
                    Text(widget.venue.rating.toString())
                  ],
                ),
                Text(widget.venue.category),
                Wrap(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}