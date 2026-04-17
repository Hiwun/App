import 'package:flutter/material.dart';

import '../separator.dart';

class NumberRangeField extends StatefulWidget {
  final String title;
  final String? hintFrom;
  final String? hintTo;
  final TextEditingController? controllerFrom;
  final TextEditingController? controllerTo;
  final FormFieldValidator<String>? validatorFrom;
  final FormFieldValidator<String>? validatorTo;
  final ValueChanged<double?>? onChangedFrom;
  final ValueChanged<double?>? onChangedTo;
  final String thousandSeparator;
  final String decimalSeparator;
  final bool ifNullReturnNull;

  // Новые параметры для префикса/суффикса
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // Новый параметр
  final double? initialValueFrom;
  final double? initialValueTo;
  final EdgeInsets? padding;

  const NumberRangeField({
    super.key,
    required this.title,
    this.hintFrom,
    this.hintTo,
    this.controllerFrom,
    this.controllerTo,
    this.validatorFrom,
    this.validatorTo,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.onChangedFrom,
    this.onChangedTo,
    this.thousandSeparator = ' ',
    this.decimalSeparator = '.',
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.ifNullReturnNull = false,
    this.initialValueFrom,
    this.initialValueTo,
  });

  @override
  State<NumberRangeField> createState() => _NumberRangeFieldState();
}

class _NumberRangeFieldState extends State<NumberRangeField> {
  late TextEditingController _controllerFrom;
  late TextEditingController _controllerTo;

  @override
  void initState() {
    super.initState();
    _controllerFrom = widget.controllerFrom ?? TextEditingController();
    _controllerTo = widget.controllerTo ?? TextEditingController();

    // Устанавливаем initialValue, если он есть и контроллер пустой
    if (widget.initialValueFrom != null && _controllerFrom.text.isEmpty) {
      _controllerFrom.text = _formatNumber(widget.initialValueFrom!);
    }
    if (widget.initialValueTo != null && _controllerTo.text.isEmpty) {
      _controllerTo.text = _formatNumber(widget.initialValueTo!);
    }
  }

  @override
  void didUpdateWidget(NumberRangeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если initialValue изменился и контроллер не пустой, обновляем
    if (widget.initialValueFrom != oldWidget.initialValueFrom &&
        widget.initialValueFrom != null &&
        widget.controllerFrom == null) {
      _controllerFrom.text = _formatNumber(widget.initialValueFrom!);
    }
    if (widget.initialValueTo != oldWidget.initialValueTo &&
        widget.initialValueTo != null &&
        widget.controllerTo == null) {
      _controllerTo.text = _formatNumber(widget.initialValueTo!);
    }
  }

  @override
  void dispose() {
    if (widget.controllerFrom == null) _controllerFrom.dispose();
    if (widget.controllerTo == null) _controllerTo.dispose();
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

  void _onChangedFrom(String formattedText) {
    final raw = _getRawValue(formattedText);
    final double? value = double.tryParse(raw);

    if(widget.ifNullReturnNull){
      widget.onChangedFrom?.call(value);
    } else {
      widget.onChangedFrom?.call(value ?? 0);
    }
  }
  void _onChangedTo(String formattedText) {
    final raw = _getRawValue(formattedText);
    final double? value = double.tryParse(raw);

    if(widget.ifNullReturnNull){
      widget.onChangedTo?.call(value);
    } else {
      widget.onChangedTo?.call(value ?? 0);
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
          child: Row(
            spacing: 15,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controllerFrom,
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
                    hintText: widget.hintFrom,
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
                    if (widget.validatorFrom != null) {
                      final raw = value != null ? _getRawValue(value) : '';
                      return widget.validatorFrom!(raw);
                    }
                    return null;
                  },
                  onChanged: _onChangedFrom,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _controllerTo,
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
                    hintText: widget.hintTo,
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
                    if (widget.validatorTo != null) {
                      final raw = value != null ? _getRawValue(value) : '';
                      return widget.validatorTo!(raw);
                    }
                    return null;
                  },
                  onChanged: _onChangedTo,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}