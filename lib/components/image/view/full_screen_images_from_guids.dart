import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FullScreenImagesFromGuids extends StatefulWidget{
  final List<UuidValue> images;
  final int initialIndex;

  const FullScreenImagesFromGuids({super.key, required this.images, required this.initialIndex});

  @override
  State<StatefulWidget> createState() => _FullScreenImagesFromGuidsState();

}

class _FullScreenImagesFromGuidsState extends State<FullScreenImagesFromGuids>{
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.5),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.transparent,
        title: Text("${_currentIndex + 1} / ${widget.images.length}", style: TextStyle(color: Colors.white)),
      ),
      body: GestureDetector(
        onVerticalDragEnd: (DragEndDetails details) => Navigator.pop(context),
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return InteractiveViewer(
              child: Center(
                child: FutureBuilder<Uint8List>(
                  future: CachedImageLoader.loadImage(widget.images[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.contain,
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
            );
          },
        ),
      ),
    );
  }
}