
enum EnumActionPropertyType { None, Rent, Sell }

extension EnumActionPropertyTypeExt on EnumActionPropertyType {
  String get label {
    switch (this) {
      case EnumActionPropertyType.None:
        return "Не выбран";
      case EnumActionPropertyType.Rent:
        return "Аренда";
      case EnumActionPropertyType.Sell:
        return "Продажа";
    }
  }

  String get key => name;
}

