import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../utils/color.dart';
import '../../../utils/cutom_text.dart';
import '../../provider/view_model/cart_view_model.dart';
import 'add_new_address_screen.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, provider, child) {
      final  getCartRes = provider.getCartRes.data?.userAddressList;

      return Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 45,
                height: 5,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const CustomText(
                "Select Address",
                fontSize: 18, fontWeight: FontWeight.bold
            ),
            const SizedBox(height: 20),
            // ----------------------
            // SAVED ADDRESS LIST
            // ----------------------
            Expanded(
              child: ListView.builder(
                itemCount: getCartRes?.length??0,
                itemBuilder: (context, index) {
                  final addr = getCartRes?[index];
                  return InkWell(
                    onTap: (){
                      // provider.selectedAddressId = addr?.id.toString();
                      // provider.selectedAddress = addr?.gpsAddress.toString();
                      provider.setSelectedAddress(addressId: addr?.id.toString(),address: addr?.gpsAddress.toString());

                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Iconsax.location, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    addr?.addressType??'',
                                    fontSize: 15, fontWeight: FontWeight.bold
                                ),
                                const SizedBox(height: 4),
                                CustomText(
                                    '${addr?.area??''},${addr?.street??''},${addr?.city??''},${addr?.state??''},${{addr?.pinCode??''}}',
                                    fontSize: 13, color: Colors.black54
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ----------------------
            // ADD NEW ADDRESS BUTTON
            // ----------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: ()async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewAddressScreen(),
                    ),
                  );
                  Navigator.pop(context);

                },
                child: const CustomText(
                    "Add New Address",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      );
    },);
  }
}