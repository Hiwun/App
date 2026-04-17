import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FullScreenImageFromGuid extends StatelessWidget{
  final UuidValue imageGuid;

  const FullScreenImageFromGuid({super.key, required this.imageGuid});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: InteractiveViewer(
          child: FutureBuilder<Uint8List>(
            future: CachedImageLoader.loadImage(imageGuid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Image.memory(
                  snapshot.data!,
                  errorBuilder: (context, error, stackTrace) {
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
                );
              } else {
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
              }
            },
          ),
        ),
      ),
    );
  }
}