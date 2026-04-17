
enum EnumObjectStatus { None, RequiresRepair, Finishing, RoughFinish, DesignerRenovation, PossibleRepairForTenant }

extension EnumObjectStatusExt on EnumObjectStatus {
  String get label {
    switch (this) {
      case EnumObjectStatus.None:
        return "Не выбран";
      case EnumObjectStatus.RequiresRepair:
        return "Требует ремонта";
      case EnumObjectStatus.Finishing:
        return "Чистовая отделка";
      case EnumObjectStatus.RoughFinish:
        return "Черновая отделка";
      case EnumObjectStatus.DesignerRenovation:
        return "Дизайнерский ремонт";
      case EnumObjectStatus.PossibleRepairForTenant:
        return "Возможен ремонт под арендатора";
    }
  }

  String get key => name;
}

