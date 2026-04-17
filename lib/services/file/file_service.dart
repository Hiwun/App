import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

class FileService{
  final Dio dio;

  FileService({required this.dio});

  Future<ApiResponse<FileModel?>> getFileMetadataByGuid(UuidValue guid) async {
    try{
      final response = await dio.get(
          '/api/realty/file/${guid.uuid}',
          options: Options(contentType: Headers.jsonContentType)
      );

      return ApiResponse<FileModel?>.fromJson(response.data, (data){
        if (data is Map<String, dynamic>) {
          return FileModel.fromJson(data);
        } else {
          return null; // или выбросить исключение
        }
      });
    } catch(e){
      rethrow;
    }
  }
  Future<Uint8List> downloadFile(UuidValue fileGuid, {Function(int received, int total)? onReceiveProgress}) async {
    try {
      final response = await dio.get(
        '/api/realty/file/${fileGuid.uuid}/download', // Ваш эндпоинт для скачивания
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (received, total) {
          if (onReceiveProgress != null && total != -1) {
            onReceiveProgress(received, total);
          }
        },
      );

      if (response.statusCode == 200) {
        return response.data as Uint8List;
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('User not found or unauthorized');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid file GUID');
      } else if (e.response?.statusCode == 404) {
        throw Exception('File not found');
      } else {
        throw Exception('Download error: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<Uint8List> downloadFileFromUrl(String url, {Function(int received, int total)? onReceiveProgress}) async {
    try {
      final newDio = Dio();
      final response = await newDio.get(
        url, // Ваш эндпоинт для скачивания
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (received, total) {
          if (onReceiveProgress != null && total != -1) {
            onReceiveProgress(received, total);
          }
        },
      );

      if (response.statusCode == 200) {
        return response.data as Uint8List;
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('User not found or unauthorized');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid file GUID');
      } else if (e.response?.statusCode == 404) {
        throw Exception('File not found');
      } else {
        throw Exception('Download error: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<String> downloadFileFromUrlToLocal({
    required String url,
    required String savePath,
    Function(int received, int total)? onReceiveProgress,
  }) async {
    try {
      final newDio = Dio();
      await newDio.download(
        url, // Ваш эндпоинт для скачивания
        savePath,
        onReceiveProgress: (received, total) {
          if (onReceiveProgress != null && total != -1) {
            onReceiveProgress(received, total);
          }
        },
      );


      return savePath;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('User not found or unauthorized');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid file GUID');
      } else if (e.response?.statusCode == 404) {
        throw Exception('File not found');
      } else {
        throw Exception('Download error: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }

// Альтернативный метод с сохранением в файл
  Future<String> downloadFileToLocal({
    required UuidValue fileGuid,
    required String savePath,
    Function(int received, int total)? onReceiveProgress,
  }) async {
    try {
      await dio.download(
        '/api/realty/file/${fileGuid.uuid}/download', // Ваш эндпоинт для скачивания
        savePath,
        onReceiveProgress: (received, total) {
          if (onReceiveProgress != null && total != -1) {
            onReceiveProgress(received, total);
          }
        },
      );

      return savePath;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('User not found or unauthorized');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid file GUID');
      } else if (e.response?.statusCode == 404) {
        throw Exception('File not found');
      } else {
        throw Exception('Download error: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteFile(UuidValue guid) async {
    try{
      await dio.delete(
          '/api/realty/file/delete/${guid.uuid}',
          options: Options(
              contentType: Headers.jsonContentType
          )
      );
    } catch(e){
      rethrow;
    }
  }
  Future<ApiResponse<FileModel>> uploadFile({
    required String filePath,
    required bool isPublic,
    required Function(int sent, int total)? onSendProgress,
  }) async {
    try{
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: File(filePath).path.split('/').last,
        ),
        'is_public': isPublic.toString(),
      });
      final response = await dio.post(
        '/api/realty/file/upload',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
        onSendProgress: (sent, total) {
          if (onSendProgress != null) {
            onSendProgress(sent, total);
          }
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse<FileModel>.fromJson(
          response.data,
              (json) => FileModel.fromJson(json as Map<String, dynamic>),
        );

        if (apiResponse.status == 'Success') {
          return apiResponse;
        } else {
          throw Exception('Upload failed: ${apiResponse.status}');
        }
      } else {
        throw Exception('Failed to upload file: ${response.statusCode}');
      }
    } catch(e){
      rethrow;
    }
  }
}