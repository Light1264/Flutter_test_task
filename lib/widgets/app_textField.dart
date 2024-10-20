import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.textFieldController,
    required this.textFieldHeader,
    this.suffixIcon,
    this.textInputType,
    this.isObsure = false,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.validator,
    required this.onChanged,
  });
  final String hintText;
  final TextEditingController textFieldController;
  final bool isObsure;
  final String textFieldHeader;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final String? Function(String?)? validator;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldHeader,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          height: 40,
          child: TextFormField(
            cursorColor: const Color(0xFF004C11),
            obscureText: isObsure,
            keyboardType: textInputType,
            controller: textFieldController,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            validator: validator,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Color(0xFF004C11)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              suffixIcon: suffixIcon,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
