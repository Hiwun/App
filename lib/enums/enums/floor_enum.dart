
enum EnumFloor { None, TheBase, MinusFirst, First, Second, Third, Fourth, Fifth, Sixth, Seventh, Eighth, Ninth, Tenth, Attic }

extension EnumFloorExt on EnumFloor {
  String get label {
    switch (this) {
      case EnumFloor.None:
        return "Не выбран";
      case EnumFloor.TheBase:
        return "Цоколь";
      case EnumFloor.MinusFirst:
        return "-1";
      case EnumFloor.First:
        return "1";
      case EnumFloor.Second:
        return "2";
      case EnumFloor.Third:
        return "3";
      case EnumFloor.Fourth:
        return "4";
      case EnumFloor.Fifth:
        return "5";
      case EnumFloor.Sixth:
        return "6";
      case EnumFloor.Seventh:
        return "7";
      case EnumFloor.Eighth:
        return "8";
      case EnumFloor.Ninth:
        return "9";
      case EnumFloor.Tenth:
        return "10";
      case EnumFloor.Attic:
        return "Мансарда";
    }
  }

  String get key => name;
}

