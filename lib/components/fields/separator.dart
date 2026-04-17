import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThousandsFormatter extends TextInputFormatter {
  final String thousandSeparator;
  final String decimalSeparator;

  ThousandsFormatter({
    this.thousandSeparator = ' ', // пробел по умолчанию
    this.decimalSeparator = '.',
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) return newValue;

    // Удаляем все существующие разделители тысяч и заменяем десятичную запятую на точку
    String cleanText = newValue.text
        .replaceAll(thousandSeparator, '')
        .replaceAll(',', '.')
        .replaceAll(' ', '.'); // любой пробельный разделитель -> точка

    // Проверяем, что в строке не больше одной точки
    final parts = cleanText.split('.');
    if (parts.length > 2) {
      // больше одной точки – некорректно, не обновляем
      return oldValue;
    }

    String integerPart = parts[0];
    String decimalPart = parts.length == 2 ? parts[1] : '';

    // Убираем ведущие нули, но оставляем один ноль, если число начинается с нуля и не имеет других цифр
    if (integerPart.length > 1 && integerPart.startsWith('0')) {
      integerPart = integerPart.replaceFirst(RegExp('^0+'), '');
      if (integerPart.isEmpty) integerPart = '0';
    }

    // Форматируем целую часть с разделителями тысяч
    String formattedInteger = _formatWithSeparators(integerPart, thousandSeparator);

    // Собираем финальную строку
    String formattedText = formattedInteger;
    if (decimalPart.isNotEmpty) {
      formattedText += decimalSeparator + decimalPart;
    }

    // Вычисляем новую позицию курсора
    int newCursorPosition = newValue.selection.baseOffset;
    // Корректировка курсора (упрощённо: после форматирования позиция может измениться)
    // Можно оставить как есть, но для простоты используем длину форматированного текста
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatWithSeparators(String integerPart, String separator) {
    if (integerPart.length <= 3) return integerPart;
    String result = '';
    for (int i = integerPart.length - 1; i >= 0; i--) {
      if ((integerPart.length - 1 - i) % 3 == 0 && i != integerPart.length - 1) {
        result = separator + result;
      }
      result = integerPart[i] + result;
    }
    return result;
  }
}