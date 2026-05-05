import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_dashboard_model.dart';
import 'package:uday_bharat/vendor_screen/widgets/custom_status_button.dart';

class OrderCardWidget extends StatelessWidget {
  final OrdersList order;
  final VoidCallback? onAccept;
  final VoidCallback? onDetails;
  String?isHome;
   OrderCardWidget({
    super.key,
    required this.order,
    this.onAccept,
    this.onDetails,
    this.isHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                '#${order.orderNumber ?? ""}',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              if(order.pickupOtp!='')
              CustomText(
                'OTP:${order.pickupOtp ?? ""}',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: (order.status == "0"
                      ? Colors.green
                      : Colors.orange)
                      .withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  order.status=='0'?'Pending':false||
                  order.status=='1'?'confirmed':false||
                  order.status=='2'?'allotted':false||
                  order.status=='3'?'shipped':false||
                  order.status=='4'?'delivered':false||
                  order.status=='5'?'cancelled':false||
                  order.status=='6'?'return_process':false||
                  order.status=='7'?'return_picked':false||
                  order.status=='8'?'returned':'',
                  fontSize: 10,
                  color: order.status == "Delivered"
                      ? Colors.green
                      : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
          if(order.deliveryBoyDetails?.id!=null)
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Allotted devilry boy: ${order.deliveryBoyDetails?.name ?? ""}",
                  fontSize: 10, color: Colors.grey[700]
              ),
             Row(children: [
               CustomNetworkImage(
                   height: 25,
                   width: 25,
                   showUserIconWhenError: true,
                   imageUrl: order.deliveryBoyDetails?.profilePhotot),
                  SizedBox(width: 10),
                   InkWell(
                     onTap: ()async{
                      callNumber(order.deliveryBoyDetails?.phone??'');
                     },
                     child: CircleAvatar(
                     backgroundColor: Colors.green,
                     radius: 13,
                     child: Icon(Icons.call,size: 15,color: Colors.white)),
                   )
             ],)
            ],
          ),
          CustomText(
            "Date: ${order.createdAt ?? "--"}",
              fontSize: 10, color: Colors.grey[700]
          ),

           Divider(height: 5,color: Colors.grey.shade200),

          // 🔸 Item List
          Column(
            children: List.generate(order.orderItems?.length ?? 0, (i) {
              final item = order.orderItems?[i];
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   CustomNetworkImage(
                       height: 40,
                       width: 40,
                       borderRadius: 20,
                       imageUrl:item?.productImages),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            item?.productName??"",
                              fontSize: 12, fontWeight: FontWeight.w500
                          ),
                          CustomText(
                            "Qty: ${item?.quantity??''}",
                              fontSize: 11, color: Colors.grey[600]
                          ),
                        ],
                      ),
                    ),
                    CustomText(
                      "₹${item?.subtotal}",
                        fontSize: 12, fontWeight: FontWeight.w500
                    ),
                  ],
                ),
              );
            }),
          ),

          Divider(height: 5,color: Colors.grey.shade200),
          // 🔹 Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                CustomText(
                    "Payment Type: ",
                    color: AppColors.grey,
                    fontSize: 12, fontWeight: FontWeight.w600
                ),
                CustomText(
                    color: AppColors.grey,
                    "${order.payment_type}",
                    fontSize: 12, fontWeight: FontWeight.w600
                ),
              ],),
             Row(children: [
               CustomText(
                   "Total",
                   fontSize: 12, fontWeight: FontWeight.w600
               ),
               CustomText(
                   "₹${order.totalAmount ?? "0"}",
                   fontSize: 12, fontWeight: FontWeight.w600
               ),
             ],)
            ],
          ),

          const SizedBox(height:5),

          // 🔹 Buttons
          ///0 accept / cancel >> 1 accept / cancel 6
          ///
          /// status 1 ho deleveryboy id ho tb shipped ho
          /// shipped >>>> 3
          ///
          if (order.status == "0")
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               CustomStatusButton(
                 isHome: isHome,
                   status:order.status,title: 'Accept',orderId: order.orderId),
              const SizedBox(width: 8),
              CancelButton(
                  isHome: isHome,
                  status:order.status,orderId: order.orderId),
            ],
          )
        ],
      ),
    );
  }


}


