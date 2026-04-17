import 'package:flutter/material.dart';
import 'package:tennisapp/components/components.dart';
import 'package:tennisapp/models/model.dart';

class FileCarouselField extends StatefulWidget{
  final double? heightContainer;
  final double? widthContainer;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Function(List<FileModel>?)? onChangeFiles;
  final List<FileModel>? files;
  final bool isEditable;
  final bool ifEmptyOnChangeReturnNull;
  final String title;
  final bool multiple;
  final bool canRemove;
  final EdgeInsets? padding;

  const FileCarouselField({
    super.key,
    this.height = 125,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.files,
    this.onChangeFiles,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.heightContainer = 125,
    this.widthContainer,
    required this.title,
    this.isEditable = false,
    this.ifEmptyOnChangeReturnNull = false,
    this.multiple = false,
    this.canRemove = false
  });

  @override
  State<StatefulWidget> createState() => _FileCarouselFieldState();
}

class _FileCarouselFieldState extends State<FileCarouselField>{



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
          child: FileCarousel(
            widthContainer: widget.widthContainer,
            heightContainer: widget.heightContainer,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            files: widget.files,
            onChangeFiles: widget.onChangeFiles,
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