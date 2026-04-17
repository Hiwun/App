
enum EnumWhoPaysCommunal { None, Tenant, Owner }

extension EnumWhoPaysCommunalExt on EnumWhoPaysCommunal{
  String get label {
    switch (this) {
      case EnumWhoPaysCommunal.None:
        return "Не выбран";
      case EnumWhoPaysCommunal.Tenant:
        return "Арендатор";
      case EnumWhoPaysCommunal.Owner:
        return "Собственник";
    }
  }

  String get key => name;
}

