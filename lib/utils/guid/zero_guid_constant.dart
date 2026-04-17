import 'package:uuid/uuid.dart';

class GuidConstants {
  static const zeroGuidString = '00000000-0000-0000-0000-000000000000';
  static final zeroGuid = Uuid.parse(zeroGuidString);
}

extension UuidExtension on Uuid {
  UuidValue get zero => Uuid().zero;

  bool isZero(UuidValue guid) {
    return guid.toString() == '00000000-0000-0000-0000-000000000000';
  }
}
