import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/progress_bar.dart';

class CustomButton extends StatelessWidget {
  String? title;
  bool isEnable;
  bool? isLoading;
  void Function() onPressed;
  Color? color;
  CustomButton(
      {super.key,
      required this.onPressed,
        required  this.title,
      this.color,
        this.isLoading,
      this.isEnable=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(15),
              backgroundColor:AppColors.appColor),
          onPressed:isLoading==true?null: onPressed,
          child:isLoading==true?CustomProgressBar():  CustomText(title.toString(),color: AppColors.white,fontSize: 16,
              fontWeight: FontWeight.w600)),
    );
  }
}
