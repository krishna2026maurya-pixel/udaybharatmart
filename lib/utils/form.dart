import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';


class CustomForm extends StatelessWidget {
  String? hintText;
  int? maxLength;
  TextEditingController? controller;
  BorderRadiusGeometry? borderRadius;
  void Function()? onTap;
  TextInputType? keyboardType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Widget? prefix;
  String? prfixText;
  bool? enabled;
  Color? bordercolor;
  String? labelText;
  final Widget? hintWidget;
  int? maxLines = 1;
  TextCapitalization? textCapitalization = TextCapitalization. none;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;
  Function(String)? onChanged;
   CustomForm({super.key,this.hintText,
     this.keyboardType,
     this.controller,
     this.suffixIcon,
     this.prefixIcon,
      this.prfixText,
     this.hintWidget,
      this.prefix,
     this.enabled,
     this.onChanged,
     this.bordercolor,
     this.validator,
     this.textCapitalization,
     this.inputFormatters,
     this.labelText,
     this.maxLines,
     this.onTap,
     this.maxLength,this.borderRadius
   });
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      enabled: enabled,
      controller:controller ,
      onChanged: onChanged,
     validator: validator,
      onTap: onTap,
      textCapitalization:textCapitalization??TextCapitalization. none,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText:hintWidget == null ? "" : null,
        counterText: '',
        labelText: labelText,
        prefixIconColor: AppColors.grey,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixText: prfixText,
        prefixIcon: prefixIcon,
        hint: hintWidget,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),

        // Normal border
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor ?? Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.appColor),
        ),
        // Disabled border
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor ?? Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        // Default border
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: bordercolor ?? Colors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        // 👇 Add this for active/focused color change
        
      ),

      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines:maxLines ,

    );
  }
}
