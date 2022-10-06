import 'package:flutter/material.dart';

class XCustomTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const XCustomTitle({
    Key? key,
    required this.title,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child: Text(title,
            style: TextStyle(
              fontSize: 24,
              color: color ?? Colors.purple.shade100,
              fontWeight: FontWeight.bold,
            )));
  }
}
