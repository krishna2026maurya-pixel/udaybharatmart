import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/vendor_screen/dashboard/add_product/add_product.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
class VendorProductListScreen extends StatefulWidget {
  const VendorProductListScreen({super.key});
  @override
  State<VendorProductListScreen> createState() =>
      _VendorProductListScreenState();
}
class _VendorProductListScreenState extends State<VendorProductListScreen> {
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductViewModel>(context,listen: false).getVendorProductListApi(context);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText("Product List",fontWeight: FontWeight.w500),
        centerTitle: true,
        backgroundColor:AppColors.appColor,
        actions: [
          IconButton(
            color: AppColors.black,
            splashRadius: 20,
            icon: const Icon(Icons.add),
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(productId: '',isEdit: false)));
            },
          )
        ],
      ),
      body: Consumer<ProductViewModel>(builder: (context, provider, child) {
        final productList = provider.getVendorProductList.productList ?? [];
        if(provider.isLoading&&isFirst==true){
          isFirst=false;
          return _buildShimmerTable(context);
        }else{
          return  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) => Colors.red.shade100),
                  headingTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  columns: [
                    DataColumn(label: CustomText("Image", fontWeight: FontWeight.w500)),
                    DataColumn(label: CustomText("Product Name", fontWeight: FontWeight.w500)),
                    DataColumn(label: CustomText("Price", fontWeight: FontWeight.w500)),
                    DataColumn(label: CustomText("MRP", fontWeight: FontWeight.w500)),
                    DataColumn(label: CustomText("Weight", fontWeight: FontWeight.w500)),
                    //DataColumn(label: CustomText("Publish", fontWeight: FontWeight.w500)),
                    DataColumn(label: CustomText("Action", fontWeight: FontWeight.w500)),
                  ],
                  rows: productList.map((product) => DataRow(
                    cells: [
                      DataCell(CustomNetworkImage(
                        imageUrl: product.productImages ?? '',
                        height: 50,
                        width: 50,
                      )),
                      DataCell(CustomText(product.productName ?? '')),
                      DataCell(CustomText("₹${product.sellingPrice ?? ''}")),
                      DataCell(CustomText("₹${product.mrp ?? ''}")),
                      DataCell(CustomText(product.quantity?.toString() ?? '0')),
                      // DataCell(Switch(
                      //   value: true,
                      //   activeColor: Colors.green,
                      //   onChanged: (value) {},
                      // )),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  AddProductScreen(
                                    productId: product.id.toString(),
                                    isEdit: true,
                              )));
                            },
                          ),
                          provider.isDeleteLoading &&
                              provider.deletingProductId == product.id.toString()
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.vendorProductDeleteApi(
                                context,
                                productId: product.id.toString(),
                              );
                            },
                          ),
                        ],
                      )),
                    ],
                  )).toList(),
                ),
              ),
            ),
          );

        }
      },)
    );
  }

  Widget _buildShimmerTable(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      scrollDirection: Axis.horizontal,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: DataTable(
          headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) => Colors.red.shade100),
          columns: const [
            DataColumn(label: CustomText("Image")),
            DataColumn(label: CustomText("Product Name")),
            DataColumn(label: CustomText("Price")),
            DataColumn(label: CustomText("MRP")),
            DataColumn(label: CustomText("Weight")),
           // DataColumn(label: CustomText("Publish")),
            DataColumn(label: CustomText("Action")),
          ],
          rows: List.generate(
            5,
                (index) => DataRow(
              cells: [
                DataCell(Container(height: 50, width: 50, color: Colors.white)),
                DataCell(Container(height: 15, width: 100, color: Colors.white)),
                DataCell(Container(height: 15, width: 60, color: Colors.white)),
                DataCell(Container(height: 15, width: 60, color: Colors.white)),
                DataCell(Container(height: 15, width: 50, color: Colors.white)),
                //DataCell(Container(height: 20, width: 40, color: Colors.white)),
                DataCell(Row(
                  children: [
                    Container(height: 20, width: 20, color: Colors.white),
                    const SizedBox(width: 10),
                    Container(height: 20, width: 20, color: Colors.white),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
