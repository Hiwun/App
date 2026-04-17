
enum EnumIntendedPurpose { None, FreeAppointment, Office, Catering, Commercial, Hotel, Production, Warehouses, Medical }

extension EnumIntendedPurposeExt on EnumIntendedPurpose {
  String get label {
    switch (this) {
      case EnumIntendedPurpose.None:
        return "Не выбран";
      case EnumIntendedPurpose.FreeAppointment:
        return "Свободного назначения";
      case EnumIntendedPurpose.Office:
        return "Офисное";
      case EnumIntendedPurpose.Catering:
        return "Общепит";
      case EnumIntendedPurpose.Commercial:
        return "Торговое";
      case EnumIntendedPurpose.Hotel:
        return "Гостиница";
      case EnumIntendedPurpose.Production:
        return "Производство";
      case EnumIntendedPurpose.Warehouses:
        return "Склады";
      case EnumIntendedPurpose.Medical:
        return "Медицинское";
    }
  }

  String get key => name;
}

