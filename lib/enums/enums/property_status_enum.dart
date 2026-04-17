
enum EnumPropertyStatus { None, Draft, Active, Inactive, Sold, Rented, Archived }

extension EnumPropertyStatusExt on EnumPropertyStatus {
  String get label {
    switch (this) {
      case EnumPropertyStatus.None:
        return "Не выбран";
      case EnumPropertyStatus.Active:
        return "Активен";
      case EnumPropertyStatus.Inactive:
        return "Не активен";
      case EnumPropertyStatus.Sold:
        return "Продан";
      case EnumPropertyStatus.Rented:
        return "Сдан";
      case EnumPropertyStatus.Archived:
        return "В архиве";
      case EnumPropertyStatus.Draft:
        return "Черновик";
    }
  }

  String get key => name;
}

