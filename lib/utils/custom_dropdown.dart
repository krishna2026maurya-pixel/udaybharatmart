import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String Function(T)? getLabel;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    this.label,
    this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
    required this.getLabel,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        // labelText: labelText,
        prefixIconColor: AppColors.grey,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // suffixIcon: suffixIcon,
        // prefix: prefix,
        // prefixText: prfixText,
        // prefixIcon: prefixIcon,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),

        // Normal border
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:  Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        // Disabled border
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        // Default border
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color:Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        // 👇 Add this for active/focused color change
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightAppColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      items: items
          .map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(getLabel!(item)),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
