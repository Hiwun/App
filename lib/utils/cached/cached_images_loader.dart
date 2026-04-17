import 'dart:typed_data';

import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid.dart';

class CachedImageLoader {
  static final Map<String, Uint8List> _cache = {};

  static Future<Uint8List> loadImage(UuidValue guid) async {
    // Проверяем кэш
    if (_cache.containsKey(guid.uuid)) {
      return _cache[guid.uuid]!;
    }

    // Загружаем изображение
    final data = await getIt<FileService>().downloadFile(guid);

    // Сохраняем в кэш
    _cache[guid.uuid] = data;

    return data;
  }
  static Future<Uint8List> loadImageFromUrl(String url) async {
    // Проверяем кэш
    if (_cache.containsKey(url)) {
      return _cache[url]!;
    }

    // Загружаем изображение
    final data = await getIt<FileService>().downloadFileFromUrl(url);

    // Сохраняем в кэш
    _cache[url] = data;

    return data;
  }
}