import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
class VendorOrderDetailPage extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String date;
  final String status;
  final List<Map<String, dynamic>> items;
  final double total;
  final String paymentMethod;
  final String deliveryAddress;

  const VendorOrderDetailPage({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.deliveryAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          "Order Details",
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColors.appColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Order Header
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Order ID: $orderId",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      "Customer: $customerName",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    CustomText(
                      "Date: $date",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        color: (status == "Delivered"
                            ? Colors.green
                            : Colors.orange)
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomText(
                        status,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: status == "Delivered"
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Item List
            const CustomText(
              "Items",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 8),

            ...List.generate(items.length, (i) {
              final item = items[i];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item["image"],
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 55),
                    ),
                  ),
                  title: CustomText(
                    item["name"],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  subtitle: CustomText(
                    "Qty: ${item["qty"]}",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  trailing: CustomText(
                    "₹${item["price"]}",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),

            const SizedBox(height: 12),

            // 🔹 Total & Payment
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Total Amount",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      "₹$total",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const Divider(height: 20),
                    const CustomText(
                      "Payment Method",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      paymentMethod,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    const Divider(height: 20),
                    const CustomText(
                      "Delivery Address",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      deliveryAddress,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (status == "Pending")
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    onPressed: () {},
                    child: const CustomText("Accept", color: AppColors.white),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {},
                  child: const CustomText("Cancel", color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

