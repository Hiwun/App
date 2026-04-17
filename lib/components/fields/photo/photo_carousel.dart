import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver2_fixed/image_gallery_saver2_fixed.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tennisapp/components/image/image.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid_value.dart';

class PhotoCarousel extends StatefulWidget{
  final double? heightContainer;
  late final double widthContainer;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Function(List<UuidValue>?)? onChangeGuids;
  final Function(List<String>?)? onChangeUrls;
  final bool ifEmptyOnChangeReturnNull;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final List<UuidValue>? imageGuids;
  final List<String>? imageUrls;
  final bool isEditable;
  final bool multiple;
  final bool canRemove;

  PhotoCarousel({
    super.key,
    this.height = 250,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.imageGuids,
    this.imageUrls,
    this.errorBuilder,
    this.onChangeGuids,
    this.onChangeUrls,
    this.ifEmptyOnChangeReturnNull = false,
    this.isEditable = false,
    this.multiple = false,
    this.canRemove = false,

    this.heightContainer = 250,
    double? widthContainer}){
      final view = WidgetsBinding.instance.platformDispatcher.views.first;
      final size = view.physicalSize;
      final pixelRatio = view.devicePixelRatio;
      this.widthContainer = widthContainer ?? size.width / pixelRatio * 0.9;

  }

  @override
  State<StatefulWidget> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel>{

  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  List<UuidValue>? _imageGuids;
  List<String>? _imageUrls;

  bool isLoading = false;
  bool isDownloadImage = false;
  int downloadImageIndex = 0;
  List<String> loadingFiles = [];


  @override
  void initState() {
    _controller.addListener(_onScroll);

    _imageGuids = widget.imageGuids;
    _imageUrls = widget.imageUrls;

    super.initState();
  }
  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PhotoCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если initialValue изменился и контроллер не пустой, обновляем
    if(!listEquals(widget.imageGuids, oldWidget.imageGuids)){
      setState(() {
        _imageGuids = widget.imageGuids;
      });
    }
    if(!listEquals(widget.imageUrls, oldWidget.imageUrls)){
      setState(() {
        _imageUrls = widget.imageUrls;
      });
    }
  }

  void _onScroll(){
    final position = _controller.position;
    if (position.hasPixels) {
      final index = (position.pixels / widget.widthContainer).round();
      if (index != _currentIndex) {
        setState(() {
          _currentIndex = index;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final photoLength = (_imageGuids?.length ?? 0) + (_imageUrls?.length ?? 0);
    final showAdd = widget.isEditable && (widget.multiple || (!widget.multiple && photoLength == 0));
    final length = photoLength + (showAdd ? 1 : 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: widget.heightContainer,
          width: widget.widthContainer,
          child: CarouselView(
            onTap: (index) async {
              bool isPhoto = photoLength == 0 || ((index + 1) > photoLength) ? false : true;
              if (!isPhoto){
                //TODO add image
                final picker = ImagePicker();
                if(widget.multiple) {
                  final files = await picker.pickMultiImage(imageQuality: 85, limit: 15);
                  setState(() {

                    loadingFiles = files.map((file) => file.path).toList();
                    isLoading = true;
                  });

                  List<UuidValue> newValues = [];
                  for (final file in files){
                    final model = await getIt<FileService>().uploadFile(filePath: file.path, isPublic: false, onSendProgress: (byte, total){});

                    newValues.add(model.data.guid);
                  }
                  setState(() {
                    if(_imageGuids != null){
                      _imageGuids = [..._imageGuids!, ...newValues];
                    } else {
                      _imageGuids = newValues;
                    }
                    loadingFiles = [];
                    isLoading = false;
                  });
                  if (widget.onChangeGuids != null){
                    if (widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
                      widget.onChangeGuids!(null);
                    } else if (!widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
                      widget.onChangeGuids!([]);
                    } else {
                      if(_imageGuids != null){
                        widget.onChangeGuids!([..._imageGuids!]);
                      } else {
                        widget.onChangeGuids!(newValues);
                      }
                    }
                  }
                } else {
                  final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
                  if (file?.path != null){
                    setState(() {
                      loadingFiles = [file!.path];
                      isLoading = true;
                    });
                    final model = await getIt<FileService>().uploadFile(filePath: file!.path, isPublic: false, onSendProgress: (byte, total){});
                    setState(() {
                      if(_imageGuids != null){
                        _imageGuids = [..._imageGuids!, model.data.guid];
                      } else {
                        _imageGuids = [model.data.guid];
                      }
                      loadingFiles = [];
                      isLoading = false;
                    });
                    if (widget.onChangeGuids != null){
                      if (widget.ifEmptyOnChangeReturnNull && [model.data.guid].isEmpty){
                        widget.onChangeGuids!(null);
                      } else if (!widget.ifEmptyOnChangeReturnNull && [model.data.guid].isEmpty){
                        widget.onChangeGuids!([]);
                      } else {
                        if(_imageGuids != null){
                          widget.onChangeGuids!([..._imageGuids!]);
                        } else {
                          widget.onChangeGuids!([model.data.guid]);
                        }
                      }
                    }
                  }
                }
              }
              else {
                _showCupertinoActionSelector(
                    context: context,
                    photoIndex: index,
                    isPhoto: isPhoto
                );
              }
            },
            controller: _controller,
            itemExtent: widget.widthContainer,
            itemSnapping: true,
            children: [
              if (_imageGuids != null)
                ..._imageGuids!.map((guid) {
                  return ImageGetter(
                    imageGuid: guid,
                    width: widget.width,
                    height: widget.height,
                    fit: widget.fit,
                    errorBuilder: widget.errorBuilder,
                  );
                }),
              if (_imageUrls != null)
                ..._imageUrls!.map((url) {
                  return ImageGetter(
                    url: url,
                    width: widget.width,
                    height: widget.height,
                    fit: widget.fit,
                    errorBuilder: widget.errorBuilder,
                  );
                }),
              if (showAdd && !isLoading)
                InkWell(
                  onTap: (){},
                  child: Container(
                    color: Colors.grey[300],
                    height: widget.height,
                    width: widget.width,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              if (isLoading)
                ...loadingFiles.map((path) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                        File(path),
                        fit: widget.fit,
                        width: widget.width,
                        height: widget.height,
                        errorBuilder: widget.errorBuilder,
                      ),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                })
            ]
          ),
        ),
        if(length > 1 && (_imageGuids != null || _imageUrls != null))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(length, (index){
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
              )
            ],
          ),
      ],
    );
  }

  Future<void> _showCupertinoActionSelector({
    required BuildContext context,
    bool isPhoto = false,
    int photoIndex = 0,
    String cancelText = "Отмена",
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        final isLoadingNotifier = ValueNotifier<bool>(false);
        return CupertinoActionSheet(
          actions: [
            if (isPhoto)
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);

                  if (_imageGuids != null){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenImagesFromGuids(images: _imageGuids!.isNotEmpty ? _imageGuids! : [], initialIndex: photoIndex)
                    ));
                  } else if (_imageUrls != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenImages(images: _imageUrls!.isNotEmpty ? _imageUrls! : [], initialIndex: photoIndex)
                    ));
                  }
                },
                child: Text('Просмотр'),
              ),
            if (isPhoto)
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);

                  final images = [
                    if(_imageGuids != null)
                      ..._imageGuids!,
                    if(_imageUrls != null)
                      ..._imageUrls!,
                  ];

                  final imageIdentity = images[photoIndex];
                  Uint8List? image;

                  if(imageIdentity is String){
                    image = await CachedImageLoader.loadImageFromUrl(imageIdentity);
                  } else if(imageIdentity is UuidValue){
                    image = await CachedImageLoader.loadImage(imageIdentity);
                  }

                  if(image == null){
                    return;
                  }

                  try{
                    setState(() {
                      isDownloadImage = true;
                      downloadImageIndex = photoIndex;
                    });

                    await ImageGallerySaver.saveImage(image);

                    setState(() {
                      isDownloadImage = false;
                      downloadImageIndex = 0;
                    });

                  } catch (e) {
                    setState(() {
                      isDownloadImage = false;
                      downloadImageIndex = 0;
                    });
                  }
                },
                child: Text('Скачать'),
              ),
            if (isPhoto && widget.canRemove)
              CupertinoActionSheetAction(
                onPressed: () async {
                  final shouldDelete = await showCupertinoDialog<bool>(
                    context: context,
                    builder: (dialogContext) => CupertinoAlertDialog(
                      title: Text('Подтверждение удаления'),
                      content: Text('Вы уверены, что хотите удалить?'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                          child: Text('Отмена'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          isDestructiveAction: true,
                          child: Text('Удалить'),
                        ),
                      ],
                    ),
                  );
                  if(shouldDelete != null && shouldDelete){
                    isLoadingNotifier.value = true;
                    final images = [
                      if (_imageGuids != null)
                        ..._imageGuids!,
                      if (_imageUrls != null)
                        ..._imageUrls!,
                    ];
                    _removeImage(images[photoIndex]);
                  }
                  Navigator.pop(context);
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoadingNotifier,
                  builder: (context, isLoading, child) {
                    if (isLoading) {
                      return const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    return const Text('Удалить');
                  },
                ),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
        );
      },
    );
  }

  Future<void> _removeImage (dynamic image) async {
    if (image is UuidValue){
      try{
        await getIt<FileService>().deleteFile(image);
        setState(() {
          _imageGuids = _imageGuids?.where((e) => e != image).toList() ?? _imageGuids;
        });
        if (widget.onChangeGuids != null){
          List<UuidValue> newValues = _imageGuids = _imageGuids?.where((e) => e.uuid != image.uuid).toList() ?? [];
          if (widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
            widget.onChangeGuids!(null);
          } else if (!widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
            widget.onChangeGuids!([]);
          } else {
            widget.onChangeGuids!(newValues);
          }
        }
      } catch (e) {
        print("error ${e.toString()}");
      }

      //TODO update photos
    } else if (image is String){
      try{
        setState(() {
          _imageUrls = _imageUrls?.where((e) => e != image).toList() ?? _imageUrls;
        });
        if (widget.onChangeUrls != null){
          List<String> newValues = _imageUrls = _imageUrls?.where((e) => e != image).toList() ?? [];
          if (widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
            widget.onChangeUrls!(null);
          } else if (!widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
            widget.onChangeUrls!([]);
          } else {
            widget.onChangeUrls!(newValues);
          }
        }
      } catch (e) {
        print("error ${e.toString()}");
      }
    } else {
      return;
    }
  }
}