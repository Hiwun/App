import 'package:flutter/material.dart';

class TextAreaField extends StatefulWidget {
  final String title;
  final String? hint;
  final int minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? padding;
  // Новый параметр
  final String? initialValue;

  const TextAreaField({
    super.key,
    required this.title,
    this.hint,
    this.minLines = 3,
    this.maxLines,
    this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
    this.validator,
    this.onChanged, this.initialValue,
  });

  @override
  State<TextAreaField> createState() => _TextAreaFieldState();
}

class _TextAreaFieldState extends State<TextAreaField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null && _controller.text.isEmpty) {
      _controller.text = widget.initialValue!;
    }
  }



  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
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
            keyboardType: TextInputType.multiline,
            minLines: widget.minLines,
            maxLines: widget.maxLines, // если null – без ограничения
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 14
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}