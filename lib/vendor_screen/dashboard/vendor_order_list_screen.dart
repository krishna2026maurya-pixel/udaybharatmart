import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/widgets/shimmer/vendor_order_shimmer.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
import 'package:uday_bharat/vendor_screen/widgets/custom_status_button.dart';

class VendorOrderListScreen extends StatefulWidget {
  String? status ;
   VendorOrderListScreen({super.key,required this.status});
  @override
  State<VendorOrderListScreen> createState() => _VendorOrderListScreenState();
}

class _VendorOrderListScreenState extends State<VendorOrderListScreen> {
  bool isFirst = true;
@override
  void initState() {
    super.initState();
   Future.microtask(() =>  Provider.of<ProductViewModel>(context, listen: false).
   vendorOrderListApi(context,status: widget.status));
   print('widget.status----------${widget.status}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "${widget.status} Orders",
            fontWeight: FontWeight.w500
        ),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body:Consumer<ProductViewModel>(builder: (context, provider, child) {
        if(isFirst==true){
          if(provider.isLoading){
            isFirst = false;
            return OrderCardShimmer();
          }
        }


        final orders = provider.getVendorOrderList.ordersList;
        if (orders == null || orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 60, color: Colors.grey),
                const SizedBox(height: 10),
                CustomText("No ${widget.status} order Found", fontSize: 16, fontWeight: FontWeight.w600),
              ],
            ),
          );
        }
          return  ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: provider.getVendorOrderList.ordersList?.length,
            itemBuilder: (context, index) {
              final order =  provider.getVendorOrderList.ordersList?[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:order?.is_scheduled=='0'?Colors.green.withOpacity(0.2): Colors.white,
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
                          '#${order?.orderNumber ?? ""}',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: (order?.status == "0"
                                ? Colors.green
                                : Colors.orange)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomText(
                            order?.status=='0'?'Pending':false||
                                order?.status=='1'?'confirmed':false||
                                order?.status=='2'?'allotted':false||
                                order?.status=='3'?'shipped':false||
                                order?.status=='4'?'delivered':false||
                                order?.status=='5'?'cancelled':false||
                                order?.status=='6'?'return_process':false||
                                order?.status=='7'?'return_picked':false||
                                order?.status=='8'?'returned':'',
                            fontSize: 10,
                            color: order?.status == "Delivered"
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Row(
                      children: [
                        // CustomText(
                        //     "Customer: ${order?.customerDetails?.name ?? ""}",
                        //     fontSize: 10, color: Colors.grey[700]
                        // ),
                        // SizedBox(width: 10),
                        if(order?.pickup_otp!='')
                        CustomText('OTP : ${order?.pickup_otp}',fontSize: 12, color: Colors.grey[700])
                      ],
                    ),
                    CustomText(
                        "Date: ${order?.createdAt ?? "--"}",
                        fontSize: 10, color: Colors.grey[700]
                    ),

                    const Divider(height: 20),

                    // 🔸 Item List
                    Column(
                      children: List.generate(order?.orderItems?.length ?? 0, (i) {
                        final item = order?.orderItems?[i];
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                            CustomNetworkImage(
                                height: 40,
                                width: 40,
                                borderRadius: 30,
                                imageUrl: item?.productImages??''),
                              const SizedBox(width: 10),
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
                                        fontSize: 10, color: Colors.grey[600]
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                  "₹${item?.subtotal}",
                                  fontSize: 12, fontWeight: FontWeight.w600
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    const Divider(height: 5),

                    // 🔹 Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Icon(Iconsax.money,size: 16,color: AppColors.blue),
                              CustomText(
                                  " Payment Type: ",
                                  color: AppColors.grey,
                                  fontSize: 12, fontWeight: FontWeight.w600
                              ),
                              CustomText(
                                  color: AppColors.grey,
                                  "${order?.paymentMethod}",
                                  fontSize: 14, fontWeight: FontWeight.w600,

                              ),
                            ],),
                            if(order?.is_scheduled=='0')
                            Row(children: [
                              Icon(Iconsax.watch,color: AppColors.blue,size: 16),
                              CustomText(
                                  " Schedule: ${order?.scheduled_at??''}",
                                  color: Colors.red,
                                  fontSize: 12, fontWeight: FontWeight.w600
                              ),
                              
                            ],),
                          ],
                        ),
                        Row(children: [
                          CustomText(
                              "Total",
                              fontSize: 12, fontWeight: FontWeight.w600
                          ),
                          CustomText(
                              "₹${order?.totalAmount ?? "0"}",
                              fontSize: 12, fontWeight: FontWeight.w600
                          ),
                        ],)
                      ],
                    ),
                    const SizedBox(height: 5),
                    // 🔹 Buttons
                    if (order?.status == "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomStatusButton(status:order?.status,title: 'Accept',orderId: order?.orderId),
                          const SizedBox(width: 8),
                          CancelButton(status:order?.status,orderId: order?.orderId),
                        ],
                      )
                  ],
                ),
              );

            },
          );
      },)
    );
  }
}
