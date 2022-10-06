import 'package:demo_weather_app/src/widget/forms/input.dart';
import 'package:flutter/material.dart';

class XSearchField extends StatelessWidget {
  final String value;
  final void Function(String)? onChanged;
  final void Function()? onSearch;
  final String? hinText;

  const XSearchField({
    Key? key,
    required this.value,
    this.onChanged,
    this.onSearch,
    this.hinText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XInput(
        value: value,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        cursorColor: const Color(0xFF686868),
        maxLines: 1,
        prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
                onTap: onSearch,
                child: const Icon(
                  Icons.search,
                  color: Color(0xFF41B245),
                ))),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: hinText,
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFACCF28)),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF41B245)),
              borderRadius: BorderRadius.circular(50),
            )));
  }
}
