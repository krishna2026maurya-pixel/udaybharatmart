import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/form.dart';
import 'package:uday_bharat/utils/progress_bar.dart';
import 'package:uday_bharat/vendor_screen/dashboard/add_product/product_lable_selector.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
import '../../widgets/product_image_widgets.dart';

class AddProductScreen extends StatefulWidget {
  String?productId;
  bool?isEdit;
   AddProductScreen({super.key,
     this.productId,
     this.isEdit=false

   });
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}
class _AddProductScreenState extends State<AddProductScreen>
    with TickerProviderStateMixin {
  List<String> productImages = [];
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductViewModel>(context,listen: false);
  Future.microtask(() {

    provider.categoryDropDownApi(context);
    if(widget.isEdit==true){
      provider.vendorAddedItemDetailApi(context,orderID: widget.productId);
    }else{
      provider.clearAllData();
    }
  },);
    provider.mrpController.addListener(provider.calculateDiscount);
    provider.sellingPriceController.addListener(provider.calculateDiscount);
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  void addAdditionalInfo() {
   final provider = Provider.of<ProductViewModel>(context,listen: false);
    setState(() {
      provider.additionalInfo.add({"title": "", "description": ""});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText("Add Product", fontWeight: FontWeight.w600),
          backgroundColor: AppColors.appColor,
        ),
        body: Consumer<ProductViewModel>(builder: (context, provider, child) {
          final getDetailRes = provider.getAddedItemDetailRes.data;
          return provider.isLoading?Center(child: CircularProgressIndicator()):

          SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionCard(
                  title: "Basic Information",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm(controller: provider.productNameCtrl,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Product Name";
                            }
                            return null;
                          },
                          labelText: "Product Name"),
                      const SizedBox(height: 10),
                      DropdownField(
                        value: provider.selectedCategory,
                        hint: "${provider.setCategoryName??'Select Category'}",
                        items: List.generate(
                          provider.dropDownCategoryRes.data?.length ?? 0,
                              (index) => provider.dropDownCategoryRes.data?[index].categoryName ?? "",
                        ),
                        onChanged: (val) {
                          setState(() {
                            provider.selectedCategory = val;
                            provider.selectedCategoryIndex =
                                provider.dropDownCategoryRes.data?.indexWhere((e) => e.categoryName == val) ?? -1;
                            // Reset dependent dropdowns
                            provider.selectedSubCategory = null;
                            provider.selectedLowCategory = null;

                            num? selectedId;
                            if (provider.selectedCategoryIndex != -1) {
                              selectedId = provider.dropDownCategoryRes.data?[provider.selectedCategoryIndex??0].id;
                            }
                            provider.selectedCategoryId = selectedId;
                            print('✅ Selected Category: $val (id: ${provider.selectedCategoryId})');
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      // SUBCATEGORY DROPDOWN
                      DropdownField(
                        value: provider.selectedSubCategory,
                        hint: "${provider.setSubCategoryName??'Select Sub Category'}",
                        items: List.generate(
                          (provider.selectedCategoryIndex != -1)
                              ? (provider.dropDownCategoryRes.data?[provider.selectedCategoryIndex??0]
                              .subCategoryList?.length ??
                              0)
                              : 0,
                              (index) => provider.dropDownCategoryRes
                              .data?[provider.selectedCategoryIndex??0]
                              .subCategoryList?[index]
                              .name ??
                              '',
                        ),

                        onChanged: (val) {
                          setState(() {
                            provider.selectedSubCategory = val;
                            provider.selectedSubCategoryIndex =
                            (provider.selectedCategoryIndex != -1)
                                ? (provider.dropDownCategoryRes.data?[provider.selectedCategoryIndex??0]
                                .subCategoryList
                                ?.indexWhere((e) => e.name == val) ??
                                -1)
                                : -1;


                            // Reset dependent dropdown
                            provider.selectedLowCategory = null;

                            num? selectedId;
                            if (provider.selectedSubCategoryIndex != -1) {
                              selectedId = provider.dropDownCategoryRes
                                  .data?[provider.selectedCategoryIndex??0]
                                  .subCategoryList?[provider.selectedSubCategoryIndex??0]
                                  .id;
                            }
                            provider.selectedSubCategoryId = selectedId;

                            print('✅ Selected Sub Category: $val (id: ${provider.selectedSubCategoryId})');
                          });
                        },
                      ),
                      // const SizedBox(height: 10),
                      //
                      // // LOW CATEGORY DROPDOWN
                      // DropdownField(
                      //   value: provider.selectedLowCategory,
                      //   hint: "Select Low Category",
                      //   items: (() {
                      //     if (provider.selectedCategoryIndex == null ||
                      //         provider.selectedCategoryIndex! < 0 ||
                      //         provider.selectedSubCategoryIndex == null ||
                      //         provider.selectedSubCategoryIndex! < 0) {
                      //       return <String>[]; // No valid selection yet
                      //     }
                      //
                      //     final data = provider.dropDownCategoryRes.data;
                      //     if (data == null ||
                      //         data.isEmpty ||
                      //         data.length <= provider.selectedCategoryIndex!) {
                      //       return <String>[]; // Prevent out-of-range
                      //     }
                      //
                      //     final subCategoryList =
                      //         data[provider.selectedCategoryIndex!].subCategoryList;
                      //     if (subCategoryList == null ||
                      //         subCategoryList.isEmpty ||
                      //         subCategoryList.length <= provider.selectedSubCategoryIndex!) {
                      //       return <String>[]; // Prevent subcategory out-of-range
                      //     }
                      //
                      //     final lowCategoryList = subCategoryList[provider.selectedSubCategoryIndex!]
                      //         .subOfSubcategoryList;
                      //
                      //     return lowCategoryList?.map((e) => e.name ?? '').toList() ?? <String>[];
                      //   })(),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       provider.selectedLowCategory = val;
                      //
                      //       final data = provider.dropDownCategoryRes.data;
                      //       if (data == null ||
                      //           provider.selectedCategoryIndex == null ||
                      //           provider.selectedSubCategoryIndex == null ||
                      //           provider.selectedCategoryIndex! < 0 ||
                      //           provider.selectedSubCategoryIndex! < 0) return;
                      //
                      //       final subCategoryList =
                      //           data[provider.selectedCategoryIndex!].subCategoryList;
                      //       if (subCategoryList == null ||
                      //           subCategoryList.isEmpty ||
                      //           subCategoryList.length <= provider.selectedSubCategoryIndex!) return;
                      //
                      //       final lowCategoryList = subCategoryList[provider.selectedSubCategoryIndex!]
                      //           .subOfSubcategoryList;
                      //       final selectedIndex =
                      //           lowCategoryList?.indexWhere((e) => e.name == val) ?? -1;
                      //
                      //       num? selectedId;
                      //       if (selectedIndex != -1 && lowCategoryList != null && lowCategoryList.length > selectedIndex) {
                      //         selectedId = lowCategoryList[selectedIndex].id;
                      //       }
                      //       provider.selectedLowCategoryId = selectedId;
                      //       print('🟧 Selected Low Category: $val (id: ${provider.selectedLowCategoryId})');
                      //     });
                      //   },
                      // ),



                      // const SizedBox(height: 10),
                      // CustomForm(controller: _brandController, hintText: "Brand"),
                      const SizedBox(height: 10),
                      ///product lable
                      ProductLabelSelector(
                        onChanged: (value) {
                          provider.productLabelController.text = value;
                        },
                      ),
                      // CustomForm(controller: _productLabelController, hintText: "Product Label (e.g Inclusive of all taxes)"),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                SectionCard(
                  title: "Quantity & Pricing",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomForm(
                              controller: provider.quantityController,
                              keyboardType: TextInputType.number,
                              labelText: "Serve Quantity",
                              validator: (val) {
                                if (val!.isEmpty) return "Please enter Serve Quantity";
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomForm(controller: provider.productNameCtrl,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter value";
                                  }
                                  return null;
                                },
                                labelText: "Value"),
                          ),
                          // Expanded(
                          //   child: DropdownField(
                          //     value: provider.selectedUnitType,
                          //     hint: "${provider.selectedUnitType??'Unit Type'}",
                          //     items: ["Kg", "grm", "ml", "pcs"],
                          //     validator: (val) {
                          //       if (val == null || val.isEmpty) return "Select Unit Type";
                          //       return null;
                          //     },
                          //     onChanged: (val) {
                          //       setState(() => provider.selectedUnitType = val);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      /// stock & Gst
                      Row(
                        children: [
                          Expanded(
                            child: CustomForm(
                              controller: provider.mrpController,
                              keyboardType: TextInputType.number,
                              labelText: "Cross Price",
                              validator: (val) {
                                if (val!.isEmpty) return "Please enter MRP";
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomForm(
                              controller: provider.sellingPriceController,
                              keyboardType: TextInputType.number,
                              labelText: "Selling Price",
                              validator: (val) {
                                if (val!.isEmpty) return "Please enter Selling Price";
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (provider.errorMessage != null)
                        CustomText(
                          provider.errorMessage!,
                            color: Colors.red, fontWeight: FontWeight.bold,
                        )
                      else if (provider.discountPercent > 0)
                        CustomText(
                          "💰 Discount: ${provider.discountPercent.toStringAsFixed(2)}%",
                            fontWeight: FontWeight.bold, color: AppColors.appColor
                        ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(
                          child: CustomForm(
                            controller: provider.stockController,
                            keyboardType: TextInputType.number,
                            labelText: "Stock",
                            validator: (val) {
                              if (val!.isEmpty) return "Please enter Stock";
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: ["0", "5", "12", "18"].contains(provider.selectedGST?.replaceAll('%', ''))
                                ? provider.selectedGST?.replaceAll('%', '')
                                : null,
                            padding: EdgeInsets.zero,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              labelText: "GST Rate",
                              labelStyle: TextStyle(color: AppColors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: AppColors.appColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                            ),
                            hint: const CustomText("GST Rate"),
                            items: ["0", "5", "12", "18"].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CustomText("$value%"),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                provider.selectedGST = val;
                              });
                            },
                          ),
                        ),

                      ],),


            ],
                  ),
                ),
                const SizedBox(height: 15),
                SectionCard(
                  title: "Product Images",
                  child: const ProductImagesWidget(),
                ),
                const SizedBox(height: 15),
                // 🔹 Additional Information
                SectionCard(
                  title: "Additional Information",
                  child: Column(
                    children: [
                      CustomForm(
                          labelText: "Title",
                          controller: provider.addInfoTitleCtrl),
                      const SizedBox(height: 6),
                      CustomForm(
                          labelText: "Description",
                          maxLines: 3,
                          controller: provider.addInfoDescCtrl),
                      const SizedBox(height: 10),
                      // ...provider.additionalInfo.asMap().entries.map((entry) {
                      //   int index = entry.key;
                      //   Map<String, String> info = entry.value;
                      //   return Column(
                      //     children: [
                      //       CustomForm(
                      //           labelText: "Title",
                      //           controller: provider.addInfoTitleCtrl),
                      //       const SizedBox(height: 6),
                      //       CustomForm(
                      //           labelText: "Description",
                      //           maxLines: 3,
                      //           controller: provider.productDescCtrl),
                      //       const SizedBox(height: 10),
                      //     ],
                      //   );
                      // }).toList(),
                      // TextButton.icon(
                      //   onPressed: addAdditionalInfo,
                      //   icon: const Icon(Icons.add),
                      //   label: const CustomText("Add More Info"),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SafeArea(
                    child: ElevatedButton(
                      onPressed:provider.isLoading?null: () {
                        if (_formKey.currentState!.validate()) {
                          provider.addProduct(context, productId: widget.productId ?? '');
                        } else {
                          print("❌ Form Invalid!");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                          backgroundColor: AppColors.appColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: provider.isLoading?CustomProgressBar():
                      CustomText(widget.isEdit==true?'Update product':'Save Product',
                          fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },)
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionCard({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
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
            CustomText(title,fontWeight: FontWeight.w600, fontSize: 15),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class DropdownField extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DropdownField({
    super.key,
    this.value,
    required this.hint,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      hint: CustomText(
        hint,
        fontSize: 14,
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
      ),
      isExpanded: true,
      validator: validator,
      onChanged: onChanged,
      items: items.toSet() // remove duplicates
          .map((e) => DropdownMenuItem(
        value: e,
        child: CustomText(e),
      ))
          .toList(),
    );
  }
}


