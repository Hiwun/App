
enum EnumCommunication { None, Water, Sewage, Gas, Electricity, Heating, ExtractorFan, FireAlarm, Ethernet }

extension EnumCommunicationExt on EnumCommunication {
  String get label {
    switch (this) {
      case EnumCommunication.None:
        return "Не выбран";
      case EnumCommunication.Water:
        return "Водоснабжение";
      case EnumCommunication.Sewage:
        return "Канализация";
      case EnumCommunication.Gas:
        return "Газ";
      case EnumCommunication.Electricity:
        return "Электричество";
      case EnumCommunication.Heating:
        return "Отопление";
      case EnumCommunication.ExtractorFan:
        return "Вытяжка";
      case EnumCommunication.FireAlarm:
        return "Пожарная сигнализация";
      case EnumCommunication.Ethernet:
        return "Интернет";
    }
  }

  String get key => name;
}

