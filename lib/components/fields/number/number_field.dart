import 'package:flutter/material.dart';

import '../separator.dart';

class NumberField extends StatefulWidget {
  final String title;
  final String? hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<double?>? onChanged;
  final String thousandSeparator;
  final String decimalSeparator;
  final bool ifNullReturnNull;

  // Новые параметры для префикса/суффикса
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // Новый параметр
  final double? initialValue;
  final EdgeInsets? padding;

  const NumberField({
    super.key,
    required this.title,
    this.hint,
    this.controller,
    this.validator,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.onChanged,
    this.thousandSeparator = ' ',
    this.decimalSeparator = '.',
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.ifNullReturnNull = false, this.initialValue,
  });

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    // Устанавливаем initialValue, если он есть и контроллер пустой
    if (widget.initialValue != null && _controller.text.isEmpty) {
      _controller.text = _formatNumber(widget.initialValue!);
    }
  }

  @override
  void didUpdateWidget(NumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если initialValue изменился и контроллер не пустой, обновляем
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != null &&
        widget.controller == null) {
      _controller.text = _formatNumber(widget.initialValue!);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  String _formatNumber(double value) {
    // Форматируем число с разделителями тысяч
    final parts = value.toString().split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    String formattedInteger = _addThousandSeparators(integerPart);

    if (decimalPart.isNotEmpty) {
      return '$formattedInteger${widget.decimalSeparator}$decimalPart';
    }
    return formattedInteger;
  }

  String _addThousandSeparators(String number) {
    if (number.length <= 3) return number;
    String result = '';
    for (int i = number.length - 1; i >= 0; i--) {
      if ((number.length - 1 - i) % 3 == 0 && i != number.length - 1) {
        result = widget.thousandSeparator + result;
      }
      result = number[i] + result;
    }
    return result;
  }

  String _getRawValue(String formatted) {
    // Удаляем разделители тысяч и заменяем десятичный разделитель на точку
    return formatted
        .replaceAll(widget.thousandSeparator, '')
        .replaceAll(widget.decimalSeparator, '.');
  }

  void _onChanged(String formattedText) {
    final raw = _getRawValue(formattedText);
    final double? value = double.tryParse(raw);

    if(widget.ifNullReturnNull){
      widget.onChanged?.call(value);
    } else {
      widget.onChanged?.call(value ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(),
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              ThousandsFormatter(
                thousandSeparator: widget.thousandSeparator,
                decimalSeparator: widget.decimalSeparator,
              ),
            ],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontSize: 14
              ),
              prefixText: widget.prefixText,
              suffixText: widget.suffixText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (widget.validator != null) {
                final raw = value != null ? _getRawValue(value) : '';
                return widget.validator!(raw);
              }
              return null;
            },
            onChanged: _onChanged,
          ),
        ),
      ],
    );
  }
}