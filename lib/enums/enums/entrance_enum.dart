
enum EnumEntrance { None, FromTheYard, FromTheStreet , FromTheEnd , ShoppingCenter }

extension EnumEntranceExt on EnumEntrance {
  String get label {
    switch (this) {
      case EnumEntrance.None:
        return "Не выбран";
      case EnumEntrance.FromTheYard:
        return "Со двора";
      case EnumEntrance.FromTheStreet:
        return "С улицы";
      case EnumEntrance.FromTheEnd:
        return "С торца";
      case EnumEntrance.ShoppingCenter:
        return "ТЦ";
    }
  }

  String get key => name;
}

