
enum EnumHeating { None, Individual, Central }

extension EnumHeatingExt on EnumHeating {
  String get label {
    switch (this) {
      case EnumHeating.None:
        return "Не выбран";
      case EnumHeating.Individual:
        return "Индивидуальное";
      case EnumHeating.Central:
        return "Центральное";
    }
  }

  String get key => name;
}

