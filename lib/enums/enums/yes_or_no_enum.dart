
enum EnumYesOrNo { None, Yes, No }

extension EnumYesOrNoExt on EnumYesOrNo {
  String get label {
    switch (this) {
      case EnumYesOrNo.None:
        return "Не выбран";
      case EnumYesOrNo.Yes:
        return "Да";
      case EnumYesOrNo.No:
        return "Нет";
    }
  }

  String get key => name;
}

