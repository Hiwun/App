
enum EnumNeedType { None, Rent, Buy }

extension EnumNeedTypeExt on EnumNeedType {
  String get label {
    switch (this) {
      case EnumNeedType.None:
        return "Не выбран";
      case EnumNeedType.Rent:
        return "Аренда";
      case EnumNeedType.Buy:
        return "Покупка";
    }
  }

  String get key => name;
}

