import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/auth_provider.dart';

class ServiceRadiusSlider extends StatefulWidget {
  const ServiceRadiusSlider({super.key});

  @override
  State<ServiceRadiusSlider> createState() => _ServiceRadiusSliderState();
}

class _ServiceRadiusSliderState extends State<ServiceRadiusSlider> {


  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Consumer<VendorAuthProvider>(builder:  (context, provider, child) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔸 Text showing radius
            CustomText(
              "${provider.serviceRadius.toStringAsFixed(0)} km Service Coverage",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            Slider(
              value: provider.serviceRadius,
              min: 0,
              max: provider.maxRadius,
              divisions: 8,
              activeColor: Colors.green,
              label: "${provider.serviceRadius.toStringAsFixed(0)} km",
              onChanged: (value) {
                provider.setServiceRadius(value);
              },
            ),
          ],
        ),
      );
    },);
  }
}
