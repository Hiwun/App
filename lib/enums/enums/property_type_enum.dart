
enum EnumPropertyType { Apartment, House, Commercial, Land }

extension EnumPropertyTypeExt on EnumPropertyType {
  String get label {
    switch (this) {
      case EnumPropertyType.Apartment:
        return "Квартира";
      case EnumPropertyType.House:
        return "Дом";
      case EnumPropertyType.Commercial:
        return "Коммерция";
      case EnumPropertyType.Land:
        return "Земля";
    }
  }

  String get key => name;
}

