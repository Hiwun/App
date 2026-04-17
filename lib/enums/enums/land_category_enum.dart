
enum EnumLandCategory { None, LandsOfSettlements, AgriculturalPurpose, IndustrialLands }

extension EnumLandCategoryExt on EnumLandCategory {
  String get label {
    switch (this) {
      case EnumLandCategory.None:
        return "Не выбран";
      case EnumLandCategory.LandsOfSettlements:
        return "Земли населенных пунктов";
      case EnumLandCategory.AgriculturalPurpose:
        return "Сельхоз назначение";
      case EnumLandCategory.IndustrialLands:
        return "Земли промышленности";
    }
  }

  String get key => name;
}

