
enum EnumRealtyType { None, Room, Building, BusinessCenter, LandPlot, Office, ReadyMadeBusiness }

extension EnumRealtyTypeExt on EnumRealtyType {
  String get label {
    switch (this) {
      case EnumRealtyType.None:
        return "Не выбран";
      case EnumRealtyType.Room:
        return "Помещение";
      case EnumRealtyType.Building:
        return "Здание";
      case EnumRealtyType.BusinessCenter:
        return "Бизнес центр";
      case EnumRealtyType.LandPlot:
        return "Земельный участок";
      case EnumRealtyType.Office:
        return "Офис";
      case EnumRealtyType.ReadyMadeBusiness:
        return "Готовый бизнес";
    }
  }

  String get key => name;
}

