import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tennisapp/components/image/image.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid_value.dart';

class FileCarousel extends StatefulWidget{
  final double? heightContainer;
  late final double widthContainer;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Function(List<FileModel>?)? onChangeFiles;
  final List<FileModel>? files;
  final bool isEditable;
  final bool ifEmptyOnChangeReturnNull;
  final bool multiple;
  final bool canRemove;

  FileCarousel({
    super.key,
    this.height = 125,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.files,
    this.onChangeFiles,
    this.isEditable = false,
    this.ifEmptyOnChangeReturnNull = false,
    this.multiple = false,
    this.canRemove = false,

    this.heightContainer = 125,
    double? widthContainer}){
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    this.widthContainer = widthContainer ?? size.width / pixelRatio * 0.45;

  }

  @override
  State<StatefulWidget> createState() => _FileCarouselState();
}

class _FileCarouselState extends State<FileCarousel>{

  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  List<FileModel>? _files;

  bool isLoading = false;
  bool isDownloadFile = false;
  int downloadIndexFile = 0;
  List<XFile> loadingFiles = [];


  @override
  void initState() {
    _controller.addListener(_onScroll);

    _files = widget.files;

    super.initState();
  }
  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
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
    final fileLength = _files?.length ?? 0;
    final showAdd = widget.isEditable && (widget.multiple || (!widget.multiple && fileLength == 0));
    final length = fileLength + (showAdd ? 1 : 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: widget.heightContainer,
          width: widget.widthContainer,
          child: CarouselView(
              onTap: (index) async {
                bool isFile = fileLength == 0 || ((index + 1) > fileLength) ? false : true;
                if (!isFile){
                  //TODO add image

                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.any,
                    allowMultiple: widget.multiple,
                  );
                  if (result == null) {
                    return;
                  }

                  setState(() {
                    loadingFiles = result.xFiles;
                    isLoading = true;
                  });

                  List<FileModel> newValues = [];
                  for (final file in result.xFiles){
                    final model = await getIt<FileService>().uploadFile(filePath: file.path, isPublic: false, onSendProgress: (byte, total){});

                    newValues.add(model.data);
                  }
                  setState(() {
                    if(_files != null){
                      _files = [..._files!, ...newValues];
                    } else {
                      _files = newValues;
                    }
                    loadingFiles = [];
                    isLoading = false;
                  });
                  if (widget.onChangeFiles != null){
                    if (widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
                      widget.onChangeFiles!(null);
                    } else if (!widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
                      widget.onChangeFiles!([]);
                    } else {
                      if(_files != null){
                        widget.onChangeFiles!([..._files!]);
                      } else {
                        widget.onChangeFiles!(newValues);
                      }
                    }
                  }
                } else {
                  _showCupertinoActionSelector(
                      context: context,
                      fileIndex: index,
                      isFile: isFile
                  );
                }
              },
              controller: _controller,
              itemExtent: widget.widthContainer,
              itemSnapping: true,
              children: [
                if (_files != null)
                  ..._files!.map((file) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.grey[300],
                          height: widget.height,
                          width: widget.width,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 6,
                            children: [
                              const Icon(
                                Icons.file_copy_outlined,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Text(
                                file.name,
                                overflow: TextOverflow.ellipsis, // Добавляет три точки в конце
                                maxLines: 1,                      // Ограничиваем одной строкой
                                textAlign: TextAlign.center,     // Центрируем текст
                              ),
                            ],
                          ),
                        ),
                        if (isDownloadFile && _currentIndex == downloadIndexFile)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                      ],
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
                  ...loadingFiles.map((file) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.grey[300],
                          height: widget.height,
                          width: widget.width,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 6,
                            children: [
                              const Icon(
                                Icons.file_copy_outlined,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Text(
                                file.name,
                                overflow: TextOverflow.ellipsis, // Добавляет три точки в конце
                                maxLines: 1,                      // Ограничиваем одной строкой
                                textAlign: TextAlign.center,     // Центрируем текст
                              ),
                            ],
                          ),
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
        if(length > 1 && (_files != null || _files != null))
          SizedBox(
            width: widget.widthContainer,
            child: Column(
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
          )
      ],
    );
  }

  Future<void> _showCupertinoActionSelector({
    required BuildContext context,
    bool isFile = false,
    int fileIndex = 0,
    String cancelText = "Отмена",
  })  {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        final isLoadingNotifier = ValueNotifier<bool>(false);
        return CupertinoActionSheet(
          actions: [
            if (isFile)
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);

                  if(_files != null){
                    final file = _files![fileIndex];

                    try{
                      setState(() {
                        isDownloadFile = true;
                        downloadIndexFile = fileIndex;
                      });
                      final fileBytes = await getIt<FileService>().downloadFile(file.guid);
                      setState(() {
                        isDownloadFile = false;
                        downloadIndexFile = 0;
                      });
                      String? outputPath = await FilePicker.platform.saveFile(
                        bytes: fileBytes,
                        dialogTitle: 'Сохранить файл',      // Заголовок окна
                        fileName: file.name,                // Предлагаемое имя файла
                        // (Опционально) Ограничить типы файлов
                        // type: FileType.custom,
                        // allowedExtensions: ['pdf', 'jpg'],
                      );

                      if (outputPath != null) {
                        return;
                      }
                    } catch (e) {
                      setState(() {
                        isDownloadFile = false;
                        downloadIndexFile = 0;
                      });
                    }
                  }
                },
                child: Text('Скачать'),
              ),
            if (isFile && widget.canRemove)
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
                    if(_files != null){
                      _removeFile(_files![fileIndex].guid);
                    }
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

  Future<void> _removeFile (UuidValue guid) async {
    try{
      await getIt<FileService>().deleteFile(guid);
      setState(() {
        _files = _files?.where((e) => e.guid != guid).toList() ?? _files;
      });
      if (widget.onChangeFiles != null){
        List<FileModel> newValues = _files = _files?.where((e) => e.guid != guid).toList() ?? [];
        if (widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
          widget.onChangeFiles!(null);
        } else if (!widget.ifEmptyOnChangeReturnNull && newValues.isEmpty){
          widget.onChangeFiles!([]);
        } else {
          widget.onChangeFiles!(newValues);
        }
      }
    } catch (e) {
      print("error ${e.toString()}");
    }
  }
}