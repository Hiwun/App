import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

class ImageGetter extends StatelessWidget{
  final UuidValue? imageGuid;
  final String? url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const ImageGetter({
    super.key,
    this.imageGuid,
    this.fit,
    this.width,
    this.height,
    this.url,
    this.errorBuilder = ImageGetter._defaultErrorBuilderFunction
  });


  @override
  Widget build(BuildContext context) {

    if (imageGuid != null){
      return FutureBuilder<Uint8List>(
        future: CachedImageLoader.loadImage(imageGuid!),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Image.memory(
              snapshot.data!,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: errorBuilder
            );
          } else {
            return _defaultErrorBuilder();
          }
        },
      );
    } else if (url != null){
      return Image.network(
        url ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/800px-Placeholder_view_vector.svg.png",
        width: width,
        height: height,
        fit: fit,
        errorBuilder: errorBuilder,
      );
    } else {
      return SizedBox();
    }
  }
  static Widget _defaultErrorBuilderFunction (BuildContext context, Object error, StackTrace? stackTrace){
    return _defaultErrorBuilder();
  }
  static Widget _defaultErrorBuilder (){
    return Container(
      color: Colors.grey[300],
      height: 200,
      alignment: Alignment.center,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}