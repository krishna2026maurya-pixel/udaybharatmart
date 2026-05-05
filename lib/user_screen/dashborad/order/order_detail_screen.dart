import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/policy/model/privacy_policy_model.dart';
import 'package:uday_bharat/user_screen/dashborad/homePage/home_page.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import '../../widgets/image_slider.dart';
import '../../widgets/shimmer/order_detail_shimmer.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:uday_bharat/user_screen/provider/model/order_detail_model.dart';
import 'generate_pdf_envice.dart';
class OrderDetailScreen extends StatefulWidget {
  String?orderID;
  String?showOrderID;
   OrderDetailScreen({super.key,this.orderID, required this.showOrderID});
  @override
  State<OrderDetailScreen> createState() =>
      _OrderDetailScreenState();
}
class _OrderDetailScreenState extends State<OrderDetailScreen>
    with TickerProviderStateMixin {
  Timer? _locationTimer;
  LatLng deliveryLatLng = const LatLng(0, 0);
  LatLng userLatLng = const LatLng(0, 0);
  Set<Marker> markers = {};
  Set<Polyline> routePolyline = {};
   bool isFirst= true;
  GoogleMapController? _mapController;
  bool _mapExpanded = false;
  late final AnimationController _animController;
  late final Animation<double> _heightFactor;
  final double _compactMapHeight = 140;
  late BitmapDescriptor deliveryIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor? userIcon;
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    final String style = await rootBundle.loadString('assets/google_map.json');
    _mapController!.setMapStyle(style);
  }
  Future<BitmapDescriptor> getMarkerIcon(String path, int size) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: size,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    final Uint8List bytes = (await frameInfo.image
        .toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }
  void loadIcons() async {
    deliveryIcon = await getMarkerIcon('assets/delevery_boy_marker.png', 110);
    // userIcon = await getMarkerIcon('assets/icons/user.png', 110);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<CategoryViewModel>(context, listen: false);
         provider .getOrderDetailApi(context, orderId: widget.orderID)
          .then((_) => {
            if(provider.getOrderDetailRes.data?.status!='4'){
              _updateMapData()
            }
      });
      loadIcons();
    });

    // Auto Refresh Every 3 Seconds
    _locationTimer = Timer.periodic(const Duration(seconds: 8), (timer) async {
      await Provider.of<CategoryViewModel>(context, listen: false)
          .getOrderDetailApi(context, orderId: widget.orderID);
      _updateMapData();
    });
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _heightFactor = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
  }

  void _toggleMapExpand() {
    setState(() {
      _mapExpanded = !_mapExpanded;
      if (_mapExpanded) {
        _animController.forward();
        Future.delayed(const Duration(milliseconds: 300), _moveCameraToBounds);
      } else {
        _animController.reverse();
      }
    });
  }
  Future<List<LatLng>> _getRoutePoints(LatLng origin, LatLng destination) async {
    final apiKey = "AIzaSyDLCESWG3BinAKTPr4ZqFMbWGULb-9Oe70";
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$apiKey";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (data["routes"].isEmpty) return [];
    String encoded = data["routes"][0]["overview_polyline"]["points"];
    return _decodePolyline(encoded);
  }
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(
        LatLng(lat / 1E5, lng / 1E5),
      );
    }
    return polyline;
  }
  dynamic? providerData ;
  _updateMapData() async {
    providerData = Provider.of<CategoryViewModel>(context, listen: false).getOrderDetailRes.data;
    if (providerData == null) return;
    final delLat = double.tryParse(providerData.deliveryBoy?.gpsLat ?? "0") ?? 0.0;
    final delLng = double.tryParse(providerData.deliveryBoy?.gpsLong ?? "0") ?? 0.0;
    final userLat = double.tryParse(providerData.shippingAddress?.gpsLat ?? "0") ?? 0.0;
    final userLng = double.tryParse(providerData.shippingAddress?.gpsLong ?? "0") ?? 0.0;
    deliveryLatLng = LatLng(delLat, delLng);
    userLatLng = LatLng(userLat, userLng);
    // 🎯 Get Full Road Route
    final routePoints = await _getRoutePoints(deliveryLatLng, userLatLng);
    // print('deliveryLat----------------${delLat}');
    // print('deliveryLat----------------${delLng}');
    routePolyline = {
      Polyline(
        color: Colors.black,
        width: 5,
        polylineId: const PolylineId("route"),
        points: routePoints,
      )
    };



      // Markers
    markers = {
      if (deliveryIcon != null)
       if(providerData.deliveryBoy?.gpsLat != null)
      Marker(
        markerId: const MarkerId('delivery'),
        position: deliveryLatLng,
        icon: deliveryIcon,
      ),
      Marker(
        markerId: const MarkerId('user'),
        position: userLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
    setState(() {});
    _moveCameraToBounds();
  }
  Future<void> _moveCameraToBounds() async {
    if (_mapController == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        (deliveryLatLng.latitude <= userLatLng.latitude)
            ? deliveryLatLng.latitude
            : userLatLng.latitude,
        (deliveryLatLng.longitude <= userLatLng.longitude) ? deliveryLatLng.longitude : userLatLng.longitude,
      ),
      northeast: LatLng(
        (deliveryLatLng.latitude >= userLatLng.latitude)
            ? deliveryLatLng.latitude
            : userLatLng.latitude,
        (deliveryLatLng.longitude >= userLatLng.longitude)
            ? deliveryLatLng.longitude
            : userLatLng.longitude,
      ),
    );

    await _mapController!
        .animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }
  // @override
  // void dispose() {
  //   _locationTimer?.cancel();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final halfScreenHeight = media.size.height * 0.55;
    return WillPopScope(
      onWillPop: (){
        _locationTimer?.cancel();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomText('${widget.showOrderID}',fontSize: 15),
          backgroundColor: AppColors.appColor,

          centerTitle: true,
          actions: [
            Consumer<CategoryViewModel>(builder: (context, value, child) {
              return  Row(
                children: [
                  CustomText(value?.getOrderDetailRes.data?.pendingOrderDetails?.deliveryEtaMinutes??'',fontWeight: FontWeight.w900),

                  CustomText(' Minute ',fontWeight: FontWeight.w600),
                  SizedBox(width: 10)
                ],
              );
            },)
          ],
        ),
        body: Consumer<CategoryViewModel>(builder: (context, provider, child) {
          final order = provider.getOrderDetailRes;
          if(isFirst==true){
            if (provider.isLoading==true) {
                isFirst=false;
              return buildOrderDetailShimmer();   // SHOW SHIMMER
            }
          }

          return  SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                if(provider?.getOrderDetailRes.data?.status!='4')
                _buildExpandableMap(halfScreenHeight,provider: provider),

                _buildStatusTimeline(order.data?.status??''),
                _buildInfoCard("Delivery address", [
                  _infoRow(Iconsax.user, order.data?.shippingAddress?.name??''),
                  _infoRow(Iconsax.call, order.data?.shippingAddress?.mobileNo??''),
                  _infoRow(Iconsax.location, order.data?.shippingAddress?.gpsAddress??''),
                ]),
                if(order.data?.status=='4')
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15),
                   child: Row(mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       ElevatedButton(
                                       onPressed: () {
                        if (order.data != null) {
                          generateInvoicePdf(order.data!);
                        }
                                       },
                                       child: Row(
                        children: [
                          Icon(Iconsax.document_download),
                          CustomText(" Download Invoices"),
                        ],
                                       ),
                                     ),
                     ],
                   ),
                 ),
                if(order.data?.deliveryBoy?.name != null && order.data?.status!='5')
                _buildInfoCard("Delivery Partner", [
                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                  Row(children: [
                    CustomNetworkImage(
                        height: 40,
                        width: 40,
                        borderRadius: 50,
                        imageUrl: order.data?.deliveryBoy?.profilePhoto??""),
                    SizedBox(width: 10),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(order.data?.deliveryBoy?.name??""),
                        CustomText(order.data?.deliveryBoy?.phone??""),
                      ],)
                  ],),
                     CircleAvatar(
                       backgroundColor: Colors.green,
                       child: IconButton(
                         onPressed: () {
                           final phoneNumber =  order.data?.deliveryBoy?.phone;
                           launchUrl(Uri.parse("tel:$phoneNumber"));
                         },
                         icon: Icon(Iconsax.call, color: Colors.white, size: 18),
                       ),
                     ),
                 ],)
                ]),
                _buildItemsSection(provider),
                _buildPaymentSummary(provider),
                const SizedBox(height: 20),
              ]),
            ),
          );
        },)
      ),
    );
  }

  // ---------------- UI PARTS ----------------
  Widget _buildExpandableMap(double halfHeight,{CategoryViewModel?provider}) {
    return GestureDetector(
      onTap: _toggleMapExpand,
      child: AnimatedBuilder(
        animation: _heightFactor,
        builder: (_, __) {
          final height =
              _compactMapHeight + (_heightFactor.value * (halfHeight - _compactMapHeight));
          return Container(
            margin: const EdgeInsets.all(16),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(children: [

                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: deliveryLatLng,
                    zoom: 20,
                  ),
                    onMapCreated: _onMapCreated,
                  markers: markers,
                  polylines: routePolyline,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,

                ),

                Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [
                          const Icon(Icons.route, color: Colors.white, size: 14),
                          const SizedBox(width: 6),
                          CustomText(_mapExpanded ? "Hide Map" : "View Route",
                              color: Colors.white, fontSize: 13)
                        ])))
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusTimeline(String statusCode) {
    MyFontSize fontSize = MyFontSize(context);
   // print('--------->OrderStatus:${statusCode}');
    const statusMap = {
      '0': 'Pending',
      '1': 'Confirm',
      '2': 'Delivery boy Allotted',
      '3': 'Out Of Delivery',
      '4': 'Delivered',
      '5': 'Cancel',
    };

    const steps = [
      'Pending',
      'Confirm',
      'Delivery boy Allotted',
      'Out Of Delivery',
      'Delivered',
    ];

    final currentStatus = statusMap[statusCode] ?? 'Pending';
    final currentIndex = steps.indexOf(currentStatus);
    final bool isCancelled = statusCode == '5';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(currentIndex!=4)
          const CustomText(
            "Order Status",
              textAlign: TextAlign.start,
              fontSize: 18, fontWeight: FontWeight.w600
          ),
          const SizedBox(height:2),
        if(currentIndex!=4)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(steps.length, (idx) {
                final s = steps[idx];
                final active = !isCancelled && idx <= currentIndex;
                final cancelled = isCancelled && s == currentStatus;
                return Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: cancelled
                          ? Colors.red
                          : (active ? Colors.green : Colors.grey[300]),
                      child: Icon(
                        cancelled
                            ? Icons.close
                            : active
                            ? Icons.check
                            : Icons.circle_outlined,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: fontSize.w/5.5,
                      child: CustomText(
                        s,
                        textAlign: TextAlign.center,
                        color: cancelled
                            ? Colors.red
                            : (active ? Colors.green : Colors.grey),
                        fontSize: 10,
                        fontWeight:
                        active ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }),
            ),
          )else
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Row(
                    children: [
                      CustomText('Delivered ',color: AppColors.white),
                      Icon(Icons.check_circle_outlined,color: AppColors.white)
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }




  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        ...children
      ]),
    );
  }

  Widget _infoRow(IconData icon, String text, {IconData? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: CustomText(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          if (trailing != null)
            IconButton(
              onPressed: () {},
              icon: Icon(trailing, color: Colors.green, size: 20),
            ),
        ],
      ),
    );
  }


  Widget _buildItemsSection(CategoryViewModel items) {
    MyFontSize fontSize =  MyFontSize(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        const CustomText("Order Items",
                   fontSize: 14, fontWeight: FontWeight.w600),
        const SizedBox(height:5),
        ...List.generate(items.getOrderDetailRes.data?.orderItems?.length??0 ,  (index) {
          final  item  = items.getOrderDetailRes.data?.orderItems?[index];
         // print('------------------${item?.productImages??''}');
          return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                      height:35,
                      imageUrl: getImageUrl(item?.productImages??''))),
              SizedBox(width: 10),
              Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                  width:fontSize.w/1.7,
                      child: CustomText(item?.productName??'',fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )),
                  CustomText("Qty: ${item?.quantity??''}",fontSize: 10),
                ],
              ),
            ],),
            Row(children: [
            CustomText("₹${item?.sellingPrice??''}",
          fontWeight: FontWeight.w600),
            ],)
          ],);
            ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImage(imageUrl: item?.productImages)),
            title: CustomText(item?.productName??'',fontSize: 12),
            subtitle: CustomText("Qty: ${item?.quantity??''}",fontSize: 10),
            trailing: CustomText("₹${item?.sellingPrice??''}",
                fontWeight: FontWeight.w600),
                      );
        },),

        const Divider(),
        Align(
            alignment: Alignment.centerRight,
            child: CustomText(
                "Total: ₹${items.getOrderDetailRes.data?.totalAmount??''}",
                fontSize: 16, fontWeight: FontWeight.bold))
      ]),
    );
  }

  Widget _buildPaymentSummary(CategoryViewModel order) {
    final getOrder = order.getOrderDetailRes.data;


    return _buildInfoCard("Payment Summary", [
      _infoRow(Icons.payment, "Method: ${getOrder?.paymentMethod}"),
      _infoRow(Icons.info_outline, "Payment: ${getOrder?.paymentStatus}"),
      _infoRow(Icons.receipt, "Subtotal: ₹${getOrder?.subtotalAmount}"),
      //_infoRow(Icons.discount, "Discount: -₹${getOrder.}"),
      _infoRow(Icons.local_shipping, "Delivery: ₹${getOrder?.deliveryCharge}"),
      const Divider(),
      _infoRow(Icons.currency_rupee, "Payable: ₹${getOrder?.totalAmount}"),
    _infoRow(
    Icons.calendar_today,
    "Date: ${formatDate(getOrder?.createdAt ?? '')}",
    )
    ]);
  }
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      DateTime parsed = DateTime.parse(date);
      return DateFormat("d MMM yyyy : HH:mm").format(parsed);
    } catch (e) {
      return date;
    }
  }

}
