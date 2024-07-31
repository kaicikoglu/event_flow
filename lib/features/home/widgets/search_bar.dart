import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomSearchBar(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromRGBO(73, 81, 86, 100),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
