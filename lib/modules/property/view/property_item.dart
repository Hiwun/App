import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/components/components.dart';
import 'package:tennisapp/enums/enum.dart';
import 'package:tennisapp/enums/enums/property_action_type_enum.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/property/bloc/property_list_bloc.dart';
import 'package:tennisapp/modules/property/view/property_profile.dart';
import 'package:uuid/uuid.dart';

import '../bloc/property_list_events.dart';

class PropertyItem extends StatefulWidget{
  final Property property;
  final PropertyListBloc bloc;
  const PropertyItem({super.key, required this.property, required this.bloc });


  @override
  State<StatefulWidget> createState() => _PropertyItemState();

}
class _PropertyItemState extends State<PropertyItem>{

  List<UuidValue> _images = [];

  _PropertyItemState(){
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    _imageContainerWidth = size.width / pixelRatio * 0.9;

  }

  @override
  void initState() {
    _images = [
      if (widget.property.previewPhotoGUID != null)
        widget.property.previewPhotoGUID!,
      if (widget.property.entrancePhotoGUID != null)
        widget.property.entrancePhotoGUID!,
      if (widget.property.unloadingPhotoGUID != null)
        widget.property.unloadingPhotoGUID!,
      if (widget.property.locationPhotoGUID != null)
        widget.property.locationPhotoGUID!,
      ...widget.property.planPhoto.map((elem) => elem.guid),
      ...widget.property.externalPhoto.map((elem) => elem.guid),
      ...widget.property.internalPhoto.map((elem) => elem.guid),
      ...widget.property.otherPhoto.map((elem) => elem.guid)
    ];
    super.initState();
  }
  late final double _imageContainerWidth;

  @override
  void didUpdateWidget(PropertyItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если initialValue изменился и контроллер не пустой, обновляем

    List<UuidValue> imagesNew = [
      if (widget.property.previewPhotoGUID != null)
        widget.property.previewPhotoGUID!,
      if (widget.property.entrancePhotoGUID != null)
        widget.property.entrancePhotoGUID!,
      if (widget.property.unloadingPhotoGUID != null)
        widget.property.unloadingPhotoGUID!,
      if (widget.property.locationPhotoGUID != null)
        widget.property.locationPhotoGUID!,
      ...widget.property.planPhoto.map((elem) => elem.guid),
      ...widget.property.externalPhoto.map((elem) => elem.guid),
      ...widget.property.internalPhoto.map((elem) => elem.guid),
      ...widget.property.otherPhoto.map((elem) => elem.guid)
    ];

    List<UuidValue> imagesOld = [
      if (oldWidget.property.previewPhotoGUID != null)
        oldWidget.property.previewPhotoGUID!,
      if (oldWidget.property.entrancePhotoGUID != null)
        oldWidget.property.entrancePhotoGUID!,
      if (oldWidget.property.unloadingPhotoGUID != null)
        oldWidget.property.unloadingPhotoGUID!,
      if (oldWidget.property.locationPhotoGUID != null)
        oldWidget.property.locationPhotoGUID!,
      ...oldWidget.property.planPhoto.map((elem) => elem.guid),
      ...oldWidget.property.externalPhoto.map((elem) => elem.guid),
      ...oldWidget.property.internalPhoto.map((elem) => elem.guid),
      ...oldWidget.property.otherPhoto.map((elem) => elem.guid)
    ];

    if(!listEquals(imagesNew, imagesOld)){
      setState(() {
        _images = imagesNew;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: 'ru');
    return InkWell(
      onTap: (){
        Navigator.of(context).push<Property>(MaterialPageRoute(
            builder: (context) => PropertyProfileView(property: widget.property)
        )).then((property) {
          if (property != null){
            widget.bloc.add(OnPropertyListUpdateOneElementEvent(newProperty: property));
            setState(() {
              _images = [
                if (property.previewPhotoGUID != null)
                  property.previewPhotoGUID!,
                if (property.entrancePhotoGUID != null)
                  property.entrancePhotoGUID!,
                if (property.unloadingPhotoGUID != null)
                  property.unloadingPhotoGUID!,
                if (property.locationPhotoGUID != null)
                  property.locationPhotoGUID!,
                ...property.planPhoto.map((elem) => elem.guid),
                ...property.externalPhoto.map((elem) => elem.guid),
                ...property.internalPhoto.map((elem) => elem.guid),
                ...property.otherPhoto.map((elem) => elem.guid)
              ];
            });
          }
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PhotoCarousel(
            imageGuids: _images,
            widthContainer: _imageContainerWidth,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: _imageContainerWidth,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  children: [
                    Text(
                      "${widget.property.title},",
                      style: TextStyle(
                        fontSize: 24,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${widget.property.addressStreet}, ${widget.property.addressHouseNumber}",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                // Row(
                //   spacing: 3,
                //   children: [
                //     IgnorePointer(
                //       ignoring: true,
                //       child: RatingBar.builder(
                //         initialRating: widget.venue.rating,
                //         minRating: 1,
                //         direction: Axis.horizontal,
                //         allowHalfRating: true,
                //         itemCount: 5,
                //         itemSize: 20,
                //         itemBuilder: (context, _) => Icon(
                //           Icons.star,
                //           color: Colors.amber,
                //         ),
                //         onRatingUpdate: (rating) {
                //
                //         },
                //       ),
                //     ),
                //     Text(widget.venue.rating.toString())
                //   ],
                // ),
                Text('Тип сделки: ${widget.property.actionType.toEnum<EnumActionPropertyType>(EnumActionPropertyType.values, fallback: EnumActionPropertyType.None).label},  ${widget.property.realtyType.toEnum<EnumRealtyType>(EnumRealtyType.values, fallback: EnumRealtyType.None).label}'),
                Text('${widget.property.priceForSquareMeter} м² / ${formatter.format(widget.property.priceForSquareMeter)} / ${formatter.format(widget.property.priceForSquareMeter)}/м²'),
                // Wrap(
                //   runSpacing: 6,
                //   spacing: 4,
                //   children: widget.venue.tags.map((tag) =>
                //       Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(8)),
                //           border: Border.fromBorderSide(
                //               BorderSide(
                //                   width: 1,
                //                   color: Color.fromRGBO(57,194,125, 1)
                //               )
                //           ),
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                //           child: Text(
                //             tag,
                //             style: TextStyle(
                //                 fontSize: 12
                //             ),
                //           ),
                //         ),
                //       )
                //   ).toList(),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}