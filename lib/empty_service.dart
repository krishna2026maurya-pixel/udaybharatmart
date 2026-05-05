import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
class EmptyServiceView extends StatelessWidget {
  final VoidCallback onChangeLocation;
  const EmptyServiceView({Key? key, required this.onChangeLocation}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/locationNotService.png',
              height: 130,
            ),
            const SizedBox(height: 20),
            const CustomText(
              'Location Not Serviceable',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              textAlign: TextAlign.center,
              color: Colors.black87,
            ),
            const SizedBox(height: 10),
            const CustomText(
              'Our team working tirelessly to bring in minute deliveries to your location',
              textAlign: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: onChangeLocation,
              icon: const Icon(Icons.location_on, color: Colors.white),
              label: const CustomText("Change Location",color: AppColors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
