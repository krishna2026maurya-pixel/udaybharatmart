import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/shadow_container.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/vendor_screen/dashboard/vendor_order_list_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
import '../../utils/session.dart';
import '../../utils/toast_msg.dart';
import '../auth/login.dart';
import '../widgets/open_alarm_permission.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/shimmer/vendor_dashboard_shimmer.dart';
import 'order/order_detail_screen.dart';
class vendorDashBoardScreen extends StatefulWidget {
  const vendorDashBoardScreen({super.key});
  @override
  State<vendorDashBoardScreen> createState() => _vendorDashBoardScreenState();
}
class _vendorDashBoardScreenState extends State<vendorDashBoardScreen> {
  bool isFirst = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      checkAndOpenAlarmPermission();

      Provider.of<ProductViewModel>(
        context,
        listen: false,
      ).vendorDashboardApi(context);

    });
  }

  Future<void> checkAndOpenAlarmPermission() async {

    if (await Permission.scheduleExactAlarm.isGranted) {
      print("✅ Alarm permission already enabled");
      return;
    }

    print("❌ Alarm permission not enabled — opening settings");

    await openAlarmPermissionSettings();
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
      return RefreshIndicator(
          color: AppColors.appColor,
          onRefresh: (){
        return Future.delayed(Duration(seconds: 1), () {
          Provider.of<ProductViewModel>(context,listen: false).vendorDashboardApi(context);
        });
      },child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              // leading: InkWell(
              //   onTap: () => VendorBottomSheet.show(context),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 15,top: 10,right: 10,bottom: 10),
              //     child: Image.asset('assets/menu.png',height: 15,width: 15,fit: BoxFit.cover),
              //   ),
              // ),
              actions: [
                InkWell(
                  onTap: ()async{
                    await MySharedPreferences.setVendorId('');
                    Utils.toastMessage('Successfully logout');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VendorLoginScreen()));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(Icons.logout)
                  ),
                ),
              ],
              leadingWidth: fontSize.w/7,
              backgroundColor:  AppColors.appColor,
              title: CustomText("Vendor Dashboard",fontWeight: FontWeight.w500),
            ),
            body:Consumer<ProductViewModel>(builder: (context, provider, child) {
              final getData = provider.getVendorDashboardRes.data;
              if(isFirst==true){
                if(provider.isLoading){
                  isFirst = false;
                  return  VendorDashboardShimmer();
                }
              }
              return Padding(
                padding: const EdgeInsets.all(12),
        
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                         // Navigator.push(context, MaterialPageRoute(builder: (context) => EditVendorProfileScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.appColor,
                                AppColors.lightAppColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(children: [
                                CustomNetworkImage(
                                    showUserIconWhenError: true,
                                    height: 50,
                                    width: 50,
                                    imageUrl: getData?.vendorDetails?.shopName??''),
        
                                SizedBox(width: fontSize.w*0.02),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(getData?.vendorDetails?.fullName??'',fontWeight: FontWeight.w500,fontSize: fontSize.w/25),
                                    CustomText(getData?.vendorDetails?.shopName??'',fontWeight: FontWeight.w500,fontSize: fontSize.w/25),
                                  ],)
                              ],)
                          ),
                        ),
                      ),
                      if(getData?.vendorDetails?.isVerified=='0')
                      ...[
                        SizedBox(height: fontSize.h*0.02),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                               Colors.red,
                                AppColors.lightAppColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CustomText('Your account is under review. Once the admin approves your profile, you will start receiving customer orders. Thank you for your patience.',fontWeight: FontWeight.w500,fontSize: fontSize.w/30),
        
                          ),
                        ),
                      ],
                      Consumer<ProductViewModel>(builder:  (context, provider, child) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          child: provider.showAnimation
                              ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => VendorOrderListScreen(status: 'new')),
                              );
                              provider. newOrderAnimationRemove();
        
                            },
                            child: Container(
                              key: const ValueKey('new_order'),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF00C853), Color(0xFF69F0AE)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.greenAccent.withOpacity(0.5),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child:  Row(
                                children: [
                                  Lottie.asset('assets/Notification.json',height: 50,width: 60,fit:BoxFit.cover),
                                  const CustomText(
                                    " New Order Arrived! Tap to View",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                        );
                      },),
        
                      SizedBox(height: fontSize.h*0.02),
                      CustomText('Dashboard Overview',fontSize: 18,fontWeight: FontWeight.w600),
                      SizedBox(height: fontSize.h*0.01),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashboardCard(getData?.vendorDetails?.walletBalance??'', 'Total Amount (Revenue)',  Iconsax.money),
                          SizedBox(width: fontSize.w*0.001),
                          dashboardCard(getData?.statistics?.total_vendor_net_amt??'', 'Net Profit\n(Your Earning)', Iconsax.money_add),
                        ],),
        
                      SizedBox(height: fontSize.h*0.02),
                      CustomText('Order Status',fontSize: 18,fontWeight: FontWeight.w600),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>VendorOrderListScreen(status:'new')));
                              },
                              child: dashboardCard3(getData?.statistics?.totalNewOrders??'', 'Total New Order',  Iconsax.box)),
                          SizedBox(width: fontSize.w*0.001),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>VendorOrderListScreen(status:'confirmed')));
                              },
                              child: dashboardCard3(getData?.statistics?.totalConfirmedOrders??'', 'Total Confirm Order', Iconsax.convert)),
                        ],),
                      SizedBox(height: fontSize.h*0.01),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>VendorOrderListScreen(status:'shipped')));
                              },
                              child: dashboardCard1(getData?.statistics?.totalShippedOrders??'', 'total Shipped Order',  Iconsax.shield)),
                          SizedBox(width: fontSize.w*0.001),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>VendorOrderListScreen(status:'delivered')));
                              },
                              child: dashboardCard1(getData?.statistics?.totalDeliveredOrders??'', 'Total Delivery Order', Iconsax.designtools)),
                          SizedBox(width: fontSize.w*0.001),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>VendorOrderListScreen(status:'cancelled')));
                              },
                              child: dashboardCard1(getData?.statistics?.totalCancelledOrders??'', 'Total Cancelled Order', Iconsax.box_remove)),
        
                        ],),
        
        
                      // SizedBox(height: fontSize.h*0.02),
                      // CustomText('Quick Action',fontSize: 18,fontWeight: FontWeight.w600),
                      // SizedBox(height: fontSize.h*0.01),
                      // Row(mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //
                      //     // InkWell(
                      //     //   onTap: (){
                      //     //     Navigator.push(context, MaterialPageRoute(builder: (_)=>VendorOrderListScreen(status:'' ,)));
                      //     //   },
                      //     //   child: Container(
                      //     //     width: fontSize.w/2.3,
                      //     //     decoration: BoxDecoration(
                      //     //       borderRadius: BorderRadius.circular(10),
                      //     //       gradient: const LinearGradient(
                      //     //         colors: [
                      //     //           AppColors.appColor,
                      //     //           AppColors.lightAppColor
                      //     //         ],
                      //     //         begin: Alignment.topLeft,
                      //     //         end: Alignment.bottomRight,
                      //     //       ),
                      //     //     ),
                      //     //     padding: EdgeInsets.all(15),
                      //     //     child: Row(children: [
                      //     //       Icon(Icons.pending_actions_sharp),
                      //     //       SizedBox(width: 10),
                      //     //       CustomText('View Orders')
                      //     //     ],),
                      //     //   ),
                      //     // )
                      //   ],),
                      SizedBox(height: fontSize.h*0.02),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('Recent Orders',fontSize: 18,fontWeight: FontWeight.w600)
                        ],),
                      //SizedBox(height: fontSize.h*0.01),
                      Column(
                        children: List.generate(getData?.ordersList?.length ?? 0, (index) {
                          return OrderCardWidget(
                            isHome: 'home',
                            order: getData!.ordersList![index],
                            onAccept: () {
                              debugPrint("Order Accepted for ID: ${getData.ordersList?[index].orderNumber}");
                            },
                            onDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VendorOrderDetailPage(
                                    orderId: getData.ordersList?[index].orderNumber??"",
                                    customerName: getData.ordersList?[index].userDetails?.mobileNo??"",
                                    date: getData.ordersList?[index].createdAt??'',
                                    status: getData.ordersList?[index].status??'',
                                    items: List<Map<String, dynamic>>.from(getData.ordersList?[index].orderItems??[]),
                                    total: double.parse(getData.ordersList?[index].totalAmount??""),
                                    paymentMethod: getData.ordersList?[index].paymentStatus??'',
                                    deliveryAddress: getData.ordersList?[index].addressDetails?.gpsAddress??"",
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
        
                    ],),
                ),
              );
            },),
            // floatingActionButton: FloatingActionButton(
            //     backgroundColor: AppColors.appColor,
            //     shape: CircleBorder(),
            //     child: Icon(Icons.add,color: AppColors.white),
            //     onPressed: (){
            //    final getData=   Provider.of<ProductViewModel>(context,listen: false).getVendorDashboardRes.data?.vendorDetails;
            //       if(getData?.isVerified=='0'){
            //         Utils.toastMessage('Your account is under review. Once the admin approves your profile, you will start add Product. Thank you for your patience.');
            //       }else{
            //         Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen()));
            //       }
            //     })
        ),
      ));


  }
  Widget dashboardCard(String count , String? title, IconData icon) {
    MyFontSize fontSize  = MyFontSize(context);
    return ShadowContainer(
      width: fontSize.w/2.2,
      height: fontSize.h/6.8,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
            ],),
          SizedBox(height: fontSize.h*0.01),
          CustomText(count,fontWeight: FontWeight.w600,fontSize: 14,),
          CustomText(title.toString(),fontWeight: FontWeight.w500,fontSize: 10),
        ],
      ),

    );
  }
  Widget dashboardCard1(String count , String? title, IconData icon) {
    MyFontSize fontSize  = MyFontSize(context);
    return ShadowContainer(
      width: fontSize.w/3.3,
      height: fontSize.h/6.8,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Icon(Icons.arrow_forward_ios_outlined,color: AppColors.grey,size: 18)

            ],),
          SizedBox(height: fontSize.h*0.01),
          CustomText(count,fontWeight: FontWeight.w600,fontSize: 14,),
          CustomText(title.toString(),fontWeight: FontWeight.w500,fontSize: 10),
        ],
      ),

    );
  }
  Widget dashboardCard3(String count , String? title, IconData icon) {
    MyFontSize fontSize  = MyFontSize(context);
    return ShadowContainer(
      width: fontSize.w/2.2,
      height: fontSize.h/7.7,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Icon(Icons.arrow_forward_ios_outlined,color: AppColors.grey,size: 18)
            ],),
          SizedBox(height: fontSize.h*0.01),
          CustomText(count,fontWeight: FontWeight.w600,fontSize: 14,),
          CustomText(title.toString(),fontWeight: FontWeight.w500,fontSize: 10),
        ],
      ),

    );
  }

}
