
enum EnumIndexType { None, ByAgreementOfParties, Unconditional }

extension EnumIndexTypeExt on EnumIndexType {
  String get label {
    switch (this) {
      case EnumIndexType.None:
        return "Не выбран";
      case EnumIndexType.ByAgreementOfParties:
        return "По соглашению сторон";
      case EnumIndexType.Unconditional:
        return "Безусловная";
    }
  }

  String get key => name;
}

