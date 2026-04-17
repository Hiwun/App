import 'package:flutter/material.dart';

import '../separator.dart';

class CurrencyRangeField extends StatefulWidget {
  final String title;
  final String? hintFrom;
  final String? hintTo;
  final String currencySymbol;
  final TextEditingController? controllerFrom;
  final TextEditingController? controllerTo;
  final FormFieldValidator<String>? validatorFrom;
  final FormFieldValidator<String>? validatorTo;
  final ValueChanged<double?>? onChangedFrom;
  final ValueChanged<double?>? onChangedTo;
  final bool ifNullReturnNull;
  final String thousandSeparator;
  final String decimalSeparator;
  // Новый параметр
  final double? initialValueFrom;
  final double? initialValueTo;
  final EdgeInsets? padding;

  const CurrencyRangeField({
    super.key,
    required this.title,
    this.hintFrom,
    this.hintTo,
    this.currencySymbol = '₽',
    this.controllerFrom,
    this.controllerTo,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.validatorFrom,
    this.validatorTo,
    this.onChangedFrom,
    this.onChangedTo,
    this.thousandSeparator = ' ',
    this.decimalSeparator = '.',
    this.ifNullReturnNull = false,
    this.initialValueFrom,
    this.initialValueTo,
  });

  @override
  State<CurrencyRangeField> createState() => _CurrencyRangeFieldState();
}

class _CurrencyRangeFieldState extends State<CurrencyRangeField> {
  late TextEditingController _controllerFrom;
  late TextEditingController _controllerTo;

  @override
  void initState() {
    super.initState();
    _controllerFrom = widget.controllerFrom ?? TextEditingController();
    _controllerTo = widget.controllerTo ?? TextEditingController();

    if (widget.initialValueFrom != null && _controllerFrom.text.isEmpty) {
      _controllerFrom.text = _formatCurrency(widget.initialValueFrom!);
    }
    if (widget.initialValueTo != null && _controllerTo.text.isEmpty) {
      _controllerTo.text = _formatCurrency(widget.initialValueTo!);
    }
  }

  @override
  void dispose() {
    if (widget.controllerFrom == null) _controllerFrom.dispose();
    if (widget.controllerTo == null) _controllerTo.dispose();
    super.dispose();
  }

  String _formatCurrency(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

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
    // Удаляем символ валюты, разделители тысяч и приводим десятичный разделитель к точке
    String withoutCurrency = formatted.replaceFirst(RegExp('^${RegExp.escape(widget.currencySymbol)}\\s*'), '');
    return withoutCurrency
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
                    prefixText: '${widget.currencySymbol} ',
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
                    prefixText: '${widget.currencySymbol} ',
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