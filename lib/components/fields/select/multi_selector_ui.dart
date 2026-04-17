import 'package:flutter/cupertino.dart';
import 'package:tennisapp/enums/enum.dart';

class CupertinoMultiSelector<T> extends StatefulWidget {
  final List<SelectOption<T>> options;
  final List<T> initial;
  final String doneText;
  final String cancelText;

  const CupertinoMultiSelector({super.key,
    required this.options,
    required this.initial,
    required this.doneText,
    required this.cancelText,
  });

  @override
  State<CupertinoMultiSelector<T>> createState() =>
      _CupertinoMultiSelectorState<T>();
}

class _CupertinoMultiSelectorState<T>
    extends State<CupertinoMultiSelector<T>> {
  late List<T> selected;

  @override
  void initState() {
    selected = List.from(widget.initial);
    super.initState();
  }

  void toggle(T value) {
    setState(() {
      if (selected.contains(value)) {
        selected.remove(value);
      } else {
        selected.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 17,
            color: CupertinoColors.label,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      child: CupertinoPopupSurface(
        child: Container(
          height: 420,
          padding: const EdgeInsets.only(
            bottom: 34,
          ),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              Expanded(child: _list()),
            ],
          ),
        ),
      ),
    );
  }
  Widget _list() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final option = widget.options[index];

        if (option.value.toString().contains("None")) {
          return const SizedBox();
        }

        final isSelected = selected.contains(option.value);

        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => toggle(option.value),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option.label,
                    style: const TextStyle(
                      fontSize: 17,
                      color: CupertinoColors.label,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    CupertinoIcons.check_mark,
                    size: 20,
                    color: CupertinoColors.systemBlue,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              widget.cancelText,
              style: const TextStyle(
                fontSize: 17,
                color: CupertinoColors.systemBlue,
                decoration: TextDecoration.none
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context, selected),
            child: Text(
              widget.doneText,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.systemBlue,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ],
      ),
    );
  }
}