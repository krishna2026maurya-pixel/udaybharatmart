

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/cutom_text.dart';

class CustomStatusButton extends StatelessWidget {
  final String? status;
  final String? title;
  final String? orderId;
  final String? isHome;
  const CustomStatusButton({super.key,this.status,this.title,this.orderId,this.isHome});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, provider, child) {
      bool isLoading = provider.loadingOrderId == orderId &&
          provider.loadingAction == "accept";
      return InkWell(
        onTap: isLoading ? null : () {
          provider.vendorUpdateStatusApi(context,
              status: '1',
              orderID: orderId,
              actionType: "accept",
              isHome: isHome,
          );
          AwesomeNotifications().cancelNotificationsByChannelKey('vendor_ring');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: isLoading
              ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
              : CustomText(title??"", color: Colors.white),
        ),
      );
    });
  }
}





class CancelButton extends StatelessWidget {
  final String? status;
  final String? orderId;
  final String? isHome;
  const CancelButton({super.key,this.status,this.orderId,this.isHome});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(builder: (context, provider, child) {
      bool isLoading = provider.loadingOrderId == orderId &&
          provider.loadingAction == "cancel";
      return InkWell(
        onTap: isLoading ? null : () {
          provider.vendorUpdateStatusApi(context,
              status: '5',
              orderID: orderId,
              actionType: "cancel",
            isHome: isHome

          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: isLoading
              ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
              : CustomText("Cancel", color: Colors.white),
        ),
      );
    });
  }
}



void callNumber(String phoneNumber) async {
  final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(callUri)) {
    await launchUrl(callUri);
  } else {
    debugPrint("Could not launch dialer");
  }
}
