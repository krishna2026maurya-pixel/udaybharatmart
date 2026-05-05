import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/dashborad/homePage/home_page.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/user_screen/widgets/shimmer/my_order_shimmer.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';

import '../../widgets/image_slider.dart' show getImageUrl;
import 'order_detail_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}
class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryViewModel>(context, listen: false).getMyOrderApi(context);
    },);
  }
  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("My Orders"),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
      ),
      body: Consumer<CategoryViewModel>(builder:  (context, provider, child) {
        final getData = provider.getMyOrderListRes.data;
        if(provider.isMyOrderLoading){
          return const Center(child: MyOrdersShimmer());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: getData?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen(
                  orderID: getData?[index].orderId,
                  showOrderID: getData?[index].orderNumber,
                ),));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Order Header ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Order ID: =${getData?[index].orderNumber}',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        CustomText(
                          getData?[index].status=='0'?"Pending":false||
                          getData?[index].status=='1'?"Confirm":false||
                          getData?[index].status=='2'?"Delivery boy Allotted":false||
                          getData?[index].status=='3'?"Out Of Delivery":false||
                              getData?[index].status=='4'?"Delivered":false||
                              getData?[index].status=='5'?"Cancel":'',
                          fontSize: 14,
                          color:   getData?[index].status=='0'?Colors.red:false||
                              getData?[index].status=='1'?Colors.blueAccent:false||
                              getData?[index].status=='2'?Colors.teal:false||
                              getData?[index].status=='3'?Colors.deepPurpleAccent:false||
                              getData?[index].status=='4'?Colors.greenAccent:false||
                              getData?[index].status=='5'?Colors.red:Colors.transparent,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                        'Date: ${getData?[index].createdAt}',
                        color: Colors.grey.shade600, fontSize: 10
                    ),
                    const Divider(height: 5),
                    // --- Item Preview ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:List.generate(getData?[index].orderItems?.length??0, (orderIndex) {
                        final order = getData?[index].orderItems?[orderIndex];
                        return Column(
                          children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             Row(children: [
                               CustomNetworkImage(
                                   height: 30,
                                   width: 30,
                                   borderRadius: 30,
                                   imageUrl:getImageUrl(order?.productImages??'') ),
                               SizedBox(width: 8),
                               SizedBox(
                                 width:fontSize.w/1.6,
                                 child: CustomText(
                                     '${order?.productName}',
                                     maxLines: 2,
                                     fontSize: 13
                                 ),
                               ),
                             ],),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      '₹${order?.sellingPrice?.split('.')[0]}',
                                      fontSize: 13,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue.shade100,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          'Qty: ${order?.quantity}',
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ],),
                            ],),
                            SizedBox(height: 5)
                          ],
                        );
                      },)
                    ),
                    CustomText(
                      ' Total Amt: ₹${getData?[index].totalAmount?.split('.')[0]}',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    SizedBox(height: 5),
                   // if(getData?[index].status=='0'||getData?[index].status=='1'||getData?[index].status=='2'||getData?[index].status=='3')
                    InkWell(

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:CustomText('Track Your Order') ,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
