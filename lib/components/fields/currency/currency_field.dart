import 'package:flutter/material.dart';

import '../separator.dart';

class CurrencyField extends StatefulWidget {
  final String title;
  final String? hint;
  final String currencySymbol;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<double?>? onChanged;
  final bool ifNullReturnNull;
  final String thousandSeparator;
  final String decimalSeparator;
  // Новый параметр
  final double? initialValue;
  final EdgeInsets? padding;

  const CurrencyField({
    super.key,
    required this.title,
    this.hint,
    this.currencySymbol = '₽',
    this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.validator,
    this.onChanged,
    this.thousandSeparator = ' ',
    this.decimalSeparator = '.',
    this.ifNullReturnNull = false, this.initialValue,
  });

  @override
  State<CurrencyField> createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null && _controller.text.isEmpty) {
      _controller.text = _formatCurrency(widget.initialValue!);
    }
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
              prefixText: '${widget.currencySymbol} ',
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