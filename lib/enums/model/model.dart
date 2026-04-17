class SelectOption<T> {
  final T value;
  final String label;

  const SelectOption({
    required this.value,
    required this.label,
  });
}

extension SelectOptionListX<T> on List<SelectOption<T>> {
  SelectOption<T>? byValue(T? value) {
    if (value == null) return null;
    try {
      return firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }

  String labelOf(T? value, {String fallback = ""}) {
    return byValue(value)?.label ?? fallback;
  }

  List<SelectOption<T>> byValues(List<T> values) {
    return where((e) => values.contains(e.value)).toList();
  }

  String labelsOf(List<T> values, {String separator = ", "}) {
    return byValues(values).map((e) => e.label).join(separator);
  }
  String labelsOfWithNoneLabel(List<T> values, {String separator = ", "}) {
    final preResult = labelsOf(values, separator: separator);
    if (preResult == ""){
      return "Не выбран";
    } else {
      return preResult;
    }
  }
}

extension EnumParser on String {
  T toEnum<T extends Enum>(
      List<T> values, {
        required T fallback,
      }) {
    return values.firstWhere(
          (e) => e.name == this,
      orElse: () => fallback,
    );
  }
}


List<T> parseEnumList<T extends Enum>(
    List<String> values,
    List<T> enumValues,
    T fallback,
    ) {
  return values.map<T>((e) {
    return enumValues.firstWhere(
          (v) => v.name == e,
      orElse: () => fallback,
    );
  }).toList();
}