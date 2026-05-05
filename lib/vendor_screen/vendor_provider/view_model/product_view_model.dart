import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/drop_down_category_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/get_business_type_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/shop_category_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_dashboard_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_order_list_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_product_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/repository/product_repo.dart';

import '../model/added_item_detail_model.dart';
class ProductViewModel extends ChangeNotifier {
  final _myRepo = VendorProductRepository();
  GetBusinessTypeModel getBusinessTypeRes = GetBusinessTypeModel();
  ShopCategoryModel getShopCategoryRes = ShopCategoryModel();
  DropDownCategoryModel dropDownCategoryRes = DropDownCategoryModel();
  VendorProductModel getVendorProductList = VendorProductModel();
  VendorDashboardModel getVendorDashboardRes = VendorDashboardModel();
  VendorOrderListModel getVendorOrderList = VendorOrderListModel();
  AddedItemDetailModel getAddedItemDetailRes = AddedItemDetailModel();
  bool isLoading = false;
  bool isCancelLoading = false;
  bool isStatusLoading = false;
  bool isDeleteLoading = false;
  int? selectedCategoryIndex;
  int? selectedSubCategoryIndex;
  File? shopImage;
  File? backAadhaar;
  File? frontAadhaar;
  final picker = ImagePicker();
  String? currentAddress;
  bool useCurrentLocation = false;
  String? getLatitude;
  String? getLongitude;
  double serviceRadius = 10;
  final double maxRadius = 50;
  void  setServiceRadius(double value) {
    serviceRadius = value;
    notifyListeners();
  }
  void setUseCurrentLocation(bool value) {
    useCurrentLocation = value;
    notifyListeners();
  }

  Future<void> pickImage(String? isShopImage) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (isShopImage=='shopImage') {
        shopImage = File(picked.path);
        notifyListeners();
      } else if(isShopImage=='backAadhaar') {
        backAadhaar = File(picked.path);
        notifyListeners();
      }else{
        frontAadhaar = File(picked.path);
        notifyListeners();
      }
    }
  }
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController categoryId = TextEditingController();
  TextEditingController subCatId = TextEditingController();
  TextEditingController lowCatId = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();

  TextEditingController addInfoTitleCtrl = TextEditingController();
  TextEditingController addInfoDescCtrl = TextEditingController();
  TextEditingController productLabelController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController pricePerItemController = TextEditingController();

  bool inStock = true;

  final weightController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final heightController = TextEditingController();

  final tagController = TextEditingController();  // SEO keywords

  String? selectedCategory;
  var selectedCategoryId;
  var selectedSubCategoryId;
  var setCategoryName;
  var setSubCategoryName;
  var setProductImage;
  String? selectedSubCategory;
  String? selectedLowCategory;
  String? selectedUnitType = "Kg";
  String? selectedGST = "0%";
  String? errorMessage;


  final List<Map<String, String>> additionalInfo = [];
  final List<File> productImages = [];
  final ImagePicker multiImagePicker = ImagePicker();
  double discountPercent = 0;


  void calculateDiscount() {
    double crossPrise = double.tryParse(mrpController.text) ?? 0;
    double sellingPrice = double.tryParse(sellingPriceController.text) ?? 0;

    if (crossPrise > 0 && sellingPrice > 0) {
      if (sellingPrice >= crossPrise) {
        errorMessage = "❌ Selling Price must be less than Cross Price (MRP)";
        discountPercent = 0;
        notifyListeners();
      } else {
        // Everything is correct
        errorMessage = null;
        discountPercent = ((crossPrise - sellingPrice) / crossPrise) * 100;
        notifyListeners();
      }
    } else {
      discountPercent = 0;
      errorMessage = null;
      notifyListeners();
    }
  }
  Future<void> pickImages() async {
    final List<XFile>? images = await multiImagePicker.pickMultiImage(
      imageQuality: 70,
    );
    if (images != null && images.isNotEmpty) {
      productImages.addAll(images.map((xfile) => File(xfile.path)));
      notifyListeners();
    }
  }
  void removeImage(int index) {
    productImages.removeAt(index);
    notifyListeners();
  }
  Future<void> getVendorProductListApi(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      getVendorProductList  =  await _myRepo.getVendorProductListRepo(context);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> addProduct(BuildContext context,{String?productId}) async {
    isLoading = true;
    notifyListeners();
    print("🟡 Upload started...");
    var url = Uri.parse('https://udaybharatmarts.com/api/vendor/products/add');
    var request = http.MultipartRequest('POST', url);
    final getUserid = await MySharedPreferences.getVendorId();
    request.fields.addAll({
      'add_info_desc': addInfoDescCtrl.text,
      'product_id': productId.toString(),
      'add_info_title': addInfoTitleCtrl.text,
      'cat_type_id': '1',
      'category': selectedCategoryId.toString(),
      'subcategory': selectedSubCategoryId.toString(),
      // 'low_category': selectedLowCategoryId.toString(),
      'vendor_id': getUserid.toString(),
      'gst': selectedGST.toString(),
      'stock': stockController.text,
      'mrp': mrpController.text,
      //'product_description': productDescCtrl.text,
      'product_label':productLabelController.text,
      'product_name': productNameCtrl.text,
      'quantity': quantityController.text,
      'selling_price': sellingPriceController.text,
      'volume': selectedUnitType.toString(),
      'brand_id': '',
    });
    // ✅ Add multiple images
    for (int i = 0; i < productImages.length; i++) {
      final image = productImages[i];
      print('🖼️ Attaching image $i: ${image.path}');
      request.files.add(await http.MultipartFile.fromPath(
        'product_image',
        image.path,
        filename: image.path.split('/').last,
       // contentType: MediaType('image', 'jpeg'),
      ));
    }

    print('Add Product Field>>>>>>>>>>>${request.fields}');
    try {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      final ioClient = IOClient(httpClient);
      print("🔵 Sending request...");
      http.StreamedResponse response = await ioClient.send(request);
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);
      print(decoded['message']);

      if (response.statusCode == 200) {
        print("✅ Product Added Successfully!");
        addInfoDescCtrl.clear();
        addInfoTitleCtrl.clear();
        productNameCtrl.clear();
        productLabelController.clear();
        mrpController.clear();
        sellingPriceController.clear();
        quantityController.clear();
        brandCtrl.clear();
        selectedCategoryId = null;
        selectedSubCategoryId = null;
        selectedGST = null;
        productImages.clear();
        notifyListeners();
        getVendorProductListApi(context);
        if (context.mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              titlePadding: const EdgeInsets.only(top: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Lottie.asset(
                        'assets/Success.json',
                        repeat: false,
                      ),
                    ),
                    const SizedBox(height: 10),
                     CustomText(
                      "${decoded['message']}",
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const CustomText("OK", color: AppColors.white),
                  ),
                )
              ],
            ),
          );
        }
      }
      else {
        print("❌ Upload Failed with status: ${response.statusCode}");
        print("Reason: ${response.reasonPhrase}");
        print("Server says: $responseBody");
      }
    } catch (e) {
      print("⚠️ Error during upload: $e");
    } finally {
      isLoading = false;
      notifyListeners();
      print("🟢 Upload process finished.");
    }
  }
  Future<void> categoryDropDownApi(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      dropDownCategoryRes  =   await _myRepo.getDropDownCategoryRepo(context);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  String? deletingProductId;
  Future<void> vendorProductDeleteApi(BuildContext context,{String?productId}) async {
    deletingProductId = productId;
    isDeleteLoading = true;
    notifyListeners();
    final userID = await MySharedPreferences.getVendorId();
    dynamic  data  = {
      'vendor_id': userID,
      'product_id': productId,
    };
    try {
      await _myRepo.vendorProductDeleteRepo(data);
      await getVendorProductListApi(context);
    } catch (error) {
      print(error);
    } finally {
      isDeleteLoading = false;
      notifyListeners();
    }
  }
  Future<void> vendorDashboardApi(BuildContext context,{String?productId}) async {
    isLoading = true;
    notifyListeners();
    final userID = await MySharedPreferences.getVendorId();
    final token = await MySharedPreferences.getFcmToken();
    dynamic  data  = {
      'vendor_id': userID??'',
      "fiberbase_token":token??'',
    };
    print('------------${data}');
    try {
      getVendorDashboardRes =  await _myRepo.vendorDashboardRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  bool hasNewOrder = false;
  bool showAnimation = false;

  void showNewOrderAnimation() {
    hasNewOrder = true;
    showAnimation = true;
    notifyListeners();
    // Future.delayed(const Duration(seconds: 200), () {
    //   showAnimation = false;
    //   notifyListeners();
    // });
  }

  void newOrderAnimationRemove() {
    hasNewOrder = false;
    showAnimation = false;
    notifyListeners();
  }

  Future<void> vendorOrderListApi(BuildContext context,{String?status}) async {
    isLoading = true;
    notifyListeners();
    final userID = await MySharedPreferences.getVendorId();
    dynamic  data  = {
      'vendor_id': userID??'',
      "status":status??'',
      "from_date":'',
      "to_date":'',
      "filter":'',
    };
    print('------------${data}');
    try {
      getVendorOrderList =  await _myRepo.vendorOrderListRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  String? loadingOrderId;
  String? loadingAction;


  Future<void> vendorUpdateStatusApi(
      BuildContext context,
      {String? status, String? orderID, String actionType = "accept",String?isHome}) async {
    loadingOrderId = orderID;
    loadingAction = actionType;
    notifyListeners();
    dynamic data = {
      'order_id': orderID ?? '',
      "status": status ?? '',
    };
    print('RequestData------------${data}');
    try {
      await _myRepo.vendorUpdateStatusRepo(data);
      if(isHome == 'home'){
        print('IsHome------------${data}');
        await vendorDashboardApi(context);
      }else{
        await vendorOrderListApi(context,status:'new');
      }
    } catch (error) {
      print(error);
    } finally {
      loadingOrderId = null;
      loadingAction = null;
      notifyListeners();
    }
  }
  void removePickedImage(int index) {
    productImages.removeAt(index);
    notifyListeners();
  }
  // void removeApiImage(int index) {
  //   final imgString = getAddedItemDetailRes?.data?.productImages;
  //
  //   if (imgString == null || imgString.isEmpty) return;
  //
  //   List<String> images = imgString.split(",");
  //
  //   images.removeAt(index);
  //
  //   // Now setter exists → no error
  //   getAddedItemDetailRes?.data?.productImages = images.join(",");
  //
  //   notifyListeners();
  // }

   void clearAllData(){
    addInfoDescCtrl.clear();
    addInfoTitleCtrl.clear();
    productNameCtrl.clear();
    productLabelController.clear();
    mrpController.clear();
    sellingPriceController.clear();
    quantityController.clear();
    brandCtrl.clear();
    selectedCategoryId = null;
    selectedSubCategoryId = null;
    selectedGST = null;
    productImages.clear();
    stockController.clear();
    setCategoryName = null;
    setSubCategoryName = null;
    selectedSubCategory =null;
    selectedCategory = null;
    setProductImage = null;
    notifyListeners();
   }

  Future<void> vendorAddedItemDetailApi(BuildContext context, {String? orderID}) async {
    notifyListeners();
    dynamic data = {
      'product_id': orderID ?? '',
    };
    try {
      getAddedItemDetailRes =   await _myRepo.vendorAddedItemDetailRepo(data);
      addInfoDescCtrl.text = getAddedItemDetailRes.data?.addInfoDesc ?? '';
      addInfoTitleCtrl.text = getAddedItemDetailRes.data?.addInfoTitle ?? '';
      productNameCtrl.text = getAddedItemDetailRes.data?.productName ?? '';
      productLabelController.text = getAddedItemDetailRes.data?.productLabel ?? '';
      mrpController.text = getAddedItemDetailRes.data?.mrp ?? '';
      sellingPriceController.text = getAddedItemDetailRes.data?.sellingPrice ?? '';
      quantityController.text = getAddedItemDetailRes.data?.quantity ?? '';
      brandCtrl.text = getAddedItemDetailRes.data?.brand ?? '';
      selectedCategoryId = getAddedItemDetailRes.data?.category ?? '';
      selectedSubCategoryId = getAddedItemDetailRes.data?.subcategory ?? '';
      setCategoryName = getAddedItemDetailRes.data?.categoryName ?? '';
      setSubCategoryName = getAddedItemDetailRes.data?.subcategoryName ?? '';
      selectedGST = getAddedItemDetailRes.data?.gst ?? '';
      stockController.text = getAddedItemDetailRes.data?.stockStatus ?? '';
      selectedUnitType = getAddedItemDetailRes.data?.volume ?? '';
      setProductImage = getAddedItemDetailRes.data?.productImages ?? '';

      print("============== ADDED ITEM DETAIL ==============");
      print("addInfoDesc          : ${addInfoDescCtrl.text}");
      print("addInfoTitle         : ${addInfoTitleCtrl.text}");
      print("productName          : ${productNameCtrl.text}");
      print("productLabel         : ${productLabelController.text}");
      print("mrp                  : ${mrpController.text}");
      print("sellingPrice         : ${sellingPriceController.text}");
      print("quantity             : ${quantityController.text}");
      print("brand                : ${brandCtrl.text}");
      print("categoryId           : $selectedCategoryId");
      print("subCategoryId        : $selectedSubCategoryId");
      print("gst                  : $selectedGST");
      print("stockStatus          : ${stockController.text}");
      print("unitType (volume)    : $selectedUnitType");
      print("================================================");


    } catch (error) {
      print(error);
    } finally {
      notifyListeners();
    }
  }

}
