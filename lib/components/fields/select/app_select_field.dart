import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennisapp/components/fields/select/multi_selector_ui.dart';
import 'package:tennisapp/enums/enum.dart';

class SelectField<T> extends StatelessWidget {
  final String title;
  final List<SelectOption<T>> options;

  final T? value;
  final List<T>? values;

  final bool isMulti;
  final bool isEditable;

  final Function(T?)? onChanged;
  final Function(List<T>)? onMultiChanged;
  final EdgeInsets? padding;

  const SelectField.single({
    super.key,
    required this.title,
    required this.options,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    required this.value,
    required this.onChanged,
    this.isEditable = false,
  })  : isMulti = false,
        values = null,
        onMultiChanged = null;

  const SelectField.multi({
    super.key,
    required this.title,
    required this.options,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    required this.values,
    required this.onMultiChanged,
    this.isEditable = false,
  })  : isMulti = true,
        value = null,
        onChanged = null;

  // @override
  // Widget build(BuildContext context) {
  //   final subtitle = isMulti
  //       ? options.labelsOf(values ?? [])
  //       : options.labelOf(value);
  //
  //   return CupertinoListTile(
  //     title: Text(title),
  //     additionalInfo: Text(subtitle),
  //     onTap: () async {
  //       if (isMulti) {
  //         final result = await showCupertinoMultiSelector<T>(
  //           context: context,
  //           options: options,
  //           values: values ?? [],
  //         );
  //
  //         if (result != null) {
  //           onMultiChanged?.call(result);
  //         }
  //       } else {
  //         final result = await showCupertinoSingleSelector<T>(
  //           context: context,
  //           options: options,
  //           value: value,
  //         );
  //
  //         if (result != null) {
  //           onChanged?.call(result);
  //         }
  //       }
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final subtitleFromValues = isMulti
        ? options.labelsOf(values ?? [])
        : options.labelOf(value);

    final subtitle = subtitleFromValues == ""
        ? 'Не выбран'
        : subtitleFromValues;



    return InkWell(
      onTap: () async {
        if (!isEditable){
          return;
        }
        if (isMulti) {
          final result = await showCupertinoMultiSelector<T>(
            context: context,
            options: options,
            values: values ?? [],
          );

          if (result != null) {
            onMultiChanged?.call(result);
          }
        } else {
          final result = await showCupertinoSingleSelector<T>(
            context: context,
            options: options,
            value: value,
          );

          if (result != null) {
            onChanged?.call(result);
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(),
            child: Text(
              subtitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<T?> showCupertinoSingleSelector<T>({
    required BuildContext context,
    required List<SelectOption<T>> options,
    T? value,
    String cancelText = "Отмена",
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (_) {
        return CupertinoActionSheet(
          actions: options.map((option) {
            final isSelected = option.value == value;

            return CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context, option.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(option.label),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    const Icon(CupertinoIcons.check_mark, size: 18),
                  ]
                ],
              ),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
        );
      },
    );
  }

  Future<List<T>?> showCupertinoMultiSelector<T>({
    required BuildContext context,
    required List<SelectOption<T>> options,
    required List<T> values,
    String doneText = "Готово",
    String cancelText = "Отмена",
  }) {
    return showCupertinoModalPopup<List<T>>(
      context: context,
      builder: (_) => CupertinoMultiSelector<T>(
        options: options,
        initial: values,
        doneText: doneText,
        cancelText: cancelText,
      ),
    );
  }
}