import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/custom_button.dart';
import '../../../utils/cutom_text.dart';

Future showSuccessDialog(BuildContext context, {String message = "Order placed successfully!",String?orderId}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/Success.json'),
              const SizedBox(height: 15),
              CustomText(
                message,
                textAlign: TextAlign.center,
                fontSize: 18,
              ),
              const SizedBox(height: 10),
              CustomText(
                "${orderId}",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),

              const SizedBox(height: 25),
              CustomButton(onPressed: (){
                Navigator.pop(context);
              }, title: 'OK')
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.green,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     onPressed: () {
              //       Navigator.pop(context); // Close dialog
              //     },
              //     child: const CustomText("OK"),
              //   ),
              // ),
            ],
          ),
        ),
      );
    },
  );
}
