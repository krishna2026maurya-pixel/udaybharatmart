import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uday_bharat/location_service/location_provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/form.dart';
import 'package:uday_bharat/utils/shadow_container.dart';
import 'package:uday_bharat/utils/size.dart';

import '../dashborad/item/category_screen.dart';
import '../provider/model/get_all_category_model.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});
  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  List<AllCategoryData> _filteredCategories = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<CategoryViewModel>(context, listen: false);
      provider.getAllCategoryApi(context).then((_) {
        setState(() {
          _filteredCategories = provider.getAllCatRes.data ?? [];
        });
      });
    });

    // Search listener
    _searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    final provider = Provider.of<CategoryViewModel>(context, listen: false);
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = provider.getAllCatRes.data ?? [];
      } else {
        _filteredCategories =
            provider.getAllCatRes.data
                ?.where(
                  (cat) =>
                      cat.categoryName?.toLowerCase().contains(query) ?? false,
                )
                .toList() ??
            [];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    final address = Provider.of<LocationProvider>(
      context,
      listen: false,
    ).fullAddress;
    return Scaffold(
      body: Consumer<CategoryViewModel>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const CategoryShimmerGrid();
          final categories = _filteredCategories;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: fontSize.h / 3.8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.repeated,
                      colors: [AppColors.appColor, AppColors.lightAppColor],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText('ZiplyMart', fontSize: 18),
                        const CustomText(
                          'in minutes delivery',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: fontSize.h * 0.001),
                        CustomText(
                          address.toString(),
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                          controller: _searchController,
                          borderRadius: BorderRadius.circular(15),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search categories...',
                          onChanged: (val) => _filterCategories(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: fontSize.h * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3 / 4.5,
                            ),
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryScreen(
                                    catId: cat.categoryId ?? '',
                                    catName: cat.categoryName ?? '',
                                  ),
                                ),
                              );
                            },
                            child: ShadowContainer(
                              borderRadius: 10,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomNetworkImage(
                                    height: fontSize.h / 10,
                                    width: fontSize.w,
                                    borderRadius: 10,
                                    imageUrl: cat.categoryImage ?? '',
                                  ),
                                  SizedBox(height: fontSize.h * 0.001),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomText(
                                      cat.categoryName ?? '',
                                      fontSize: 12,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: fontSize.h * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Shimmer loader
class CategoryShimmerGrid extends StatelessWidget {
  const CategoryShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: height * 0.09,
                      width: width,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(height: 12, width: 60, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            itemCount: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.65, // Increased vertical space
            ),
            itemBuilder: (_, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60, // Fixed size for consistency
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(height: 10, width: 50, color: Colors.white),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
