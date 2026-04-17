import 'package:flutter/material.dart';

class FullScreenImages extends StatefulWidget{
  final List<String> images;
  final int initialIndex;

  const FullScreenImages({super.key, required this.images, required this.initialIndex});

  @override
  State<StatefulWidget> createState() => _FullScreenImagesState();

}

class _FullScreenImagesState extends State<FullScreenImages>{
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
                child: Image.network(widget.images[index], fit: BoxFit.contain),
              ),
            );
          },
        ),
      ),
    );
  }
}