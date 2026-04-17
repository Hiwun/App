
enum EnumLineOfPlacement { None, FirstLine, SecondLineAndBeyond , InsideResidentialArea , IndustrialZone }

extension EnumLineOfPlacementExt on EnumLineOfPlacement {
  String get label {
    switch (this) {
      case EnumLineOfPlacement.None:
        return "Не выбран";
      case EnumLineOfPlacement.FirstLine:
        return "Первая линия";
      case EnumLineOfPlacement.SecondLineAndBeyond:
        return "Вторая линия и далее";
      case EnumLineOfPlacement.InsideResidentialArea:
        return "Внутри жилого массива";
      case EnumLineOfPlacement.IndustrialZone:
        return "Промзона";
    }
  }

  String get key => name;
}

