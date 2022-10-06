import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XInput extends StatefulWidget {
  const XInput({
    required this.value,
    Key? key,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.decoration,
    this.textAlign = TextAlign.left,
    this.style,
    this.maxLength,
    this.autofocus = false,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.cursorColor,
    this.cursorHeight,
    this.maxLines,
    this.textInputAction,
  }) : super(key: key);
  final String value;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final int? maxLength;
  final bool autofocus;
  // style
  final TextAlign textAlign;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? cursorColor;
  final double? cursorHeight;
  final int? maxLines;
  final TextInputAction? textInputAction;

  @override
  State<XInput> createState() => _XInputState();
}

class _XInputState extends State<XInput> {
  late TextEditingController _controller;
  String get value => widget.value;
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(XInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? _buildActions() {
      final List<Widget> actions = [];
      if (value.isNotEmpty) {
        actions.add(
          InkWell(
            onTap: () {
              widget.onChanged?.call('');
            },
            child: const Icon(
              Icons.cancel,
              color: Color(0xFFB9C0C7),
            ),
          ),
        );
      }
      if (widget.suffixIcon != null) {
        actions.add(widget.suffixIcon!);
      }
      if (widget.obscureText) {
        actions.add(
          IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFFB9C0C7),
            ),
          ),
        );
      }

      if (actions.isEmpty) {
        return null;
      }
      if (actions.length == 1) {
        return actions[0];
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      );
    }

    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      style: widget.style,
      cursorColor: widget.cursorColor,
      cursorHeight: widget.cursorHeight,
      textAlign: widget.textAlign,
      obscureText: obscureText,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      inputFormatters: widget.inputFormatters,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        prefixIcon: widget.prefixIcon,
        labelStyle: const TextStyle(color: Color(0xFF475569)),
        errorStyle: const TextStyle(fontSize: 14, letterSpacing: 0.25),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: false,
        suffixIcon: _buildActions(),
      ),
    );
  }
}
