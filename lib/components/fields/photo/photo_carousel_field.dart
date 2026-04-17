import 'package:flutter/material.dart';
import 'package:tennisapp/components/components.dart';
import 'package:uuid/uuid_value.dart';

class PhotoCarouselField extends StatefulWidget{
  final double? heightContainer;
  final double? widthContainer;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Function(List<UuidValue>?)? onChangeGuids;
  final Function(List<String>?)? onChangeUrls;
  final bool ifEmptyOnChangeReturnNull;
  final List<UuidValue>? imageGuids;
  final List<String>? imageUrls;
  final String title;
  final bool isEditable;
  final bool multiple;
  final bool canRemove;
  final EdgeInsets? padding;

  const PhotoCarouselField({
    super.key,
    this.height = 250,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.imageGuids,
    this.imageUrls,
    this.errorBuilder,
    this.onChangeGuids,
    this.onChangeUrls,
    this.ifEmptyOnChangeReturnNull = false,
    this.heightContainer = 250,
    this.widthContainer,
    required this.title,
    this.isEditable = false,
    this.multiple = false,
    this.canRemove = false
  });

  @override
  State<StatefulWidget> createState() => _PhotoCarouselFieldState();
}

class _PhotoCarouselFieldState extends State<PhotoCarouselField>{



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(),
          child: PhotoCarousel(
            widthContainer: widget.widthContainer,
            heightContainer: widget.heightContainer,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            imageUrls: widget.imageUrls,
            imageGuids: widget.imageGuids,
            errorBuilder: widget.errorBuilder,
            onChangeUrls: widget.onChangeUrls,
            onChangeGuids: widget.onChangeGuids,
            ifEmptyOnChangeReturnNull: widget.ifEmptyOnChangeReturnNull,
            isEditable: widget.isEditable,
            multiple: widget.multiple,
            canRemove: widget.canRemove,
          ),
        ),
      ],
    );
  }
}