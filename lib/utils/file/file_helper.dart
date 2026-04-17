
import 'package:uuid/uuid.dart';

class FileHelper {
  static String getFileUrl(UuidValue fileGuid) {
    return 'https://backend.uniquiq.ru/api/realty/public/file/${fileGuid.uuid}/download';
  }

}