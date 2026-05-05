import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:uday_bharat/user_screen/dashborad/dashboard.dart';

import '../../utils/color.dart';
import '../../utils/cutom_text.dart';
import '../dashborad/cart/cart_screen.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/Empty cart.json', height: 150),
          const SizedBox(height: 16),
          const CustomText(
            "Your cart is empty",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 6),
          const CustomText(
            "Add items to proceed with checkout.",
            color: Colors.black54,
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
                (Route route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyle.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const CustomText("Continue Shopping", color: Colors.white),
          ),
        ],
      ),
    );
  }
}

Widget cartCheckoutButton({
  required bool showCartBar,
  int? totalCartQty,
  int? totalSavedAmount,
  int? grandTotalAmount,
}) {
  return Builder(
    builder: (context) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartCheckoutScreen()),
            );
          },
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 400),
            offset: showCartBar ? Offset(0, 0) : Offset(0, 1),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: showCartBar ? 1 : 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.greenColor,
                            ),
                            CustomText(
                              ' Saved ₹${totalSavedAmount ?? '0'}',
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        CustomText(
                          '₹${grandTotalAmount ?? '0'}',
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/shopping-cart.png', height: 30),

                            /// Icon(Iconsax.shopping_cart,color: AppColors.black),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "Cart",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  "${totalCartQty ?? ''} items",
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.appColor,
                          ),
                          child: Row(
                            children: [
                              CustomText(
                                'View Cart',
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppColors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
