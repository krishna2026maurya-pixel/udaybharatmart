import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/all_category/all_category_screen.dart';
import 'package:uday_bharat/user_screen/dashborad/item/category_screen.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/utils/size.dart';

import '../../location_service/location_provider.dart';
import '../../location_service/update_item_location.dart';
import '../../utils/cache_image.dart';
import '../../utils/color.dart';
import '../../utils/cutom_text.dart';
import '../../utils/form.dart';
import '../dashborad/searh_item_screen/search_item_screen.dart';
import '../provider/model/home_page_model.dart';

class HomeHederWidget extends StatefulWidget {
  const HomeHederWidget({super.key});

  @override
  State<HomeHederWidget> createState() => _HomeHederWidgetState();
}

class _HomeHederWidgetState extends State<HomeHederWidget> {
  late LocationProvider locationProvider;
  @override
  void initState() {
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);

    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        final getHomeData = homeProvider.userHomeRes.data;
        return Container(
          padding: EdgeInsets.all(10),
          height: fontSize.h / 2.5,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.appColor,
                AppColors.lightAppColor,
                // AppColors.lightAppColor,
                AppColors.lightAppColor.withOpacity(0.2),
                AppColors.lightAppColor.withOpacity(0.2),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: fontSize.h * 0.02),

                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Fast Delivery',
                              textStyle: GoogleFonts.archivoBlack(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: [
                                Colors.black,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.purple,
                              ],
                              speed: const Duration(milliseconds: 400),
                            ),
                          ],
                        ),

                        SizedBox(height: fontSize.h * 0.01),
                        InkWell(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => const FractionallySizedBox(
                                heightFactor: 0.96,
                                child: SelectLocationBottomSheet(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 5),
                              Consumer<LocationProvider>(
                                builder: (context, value, child) {
                                  return SizedBox(
                                    width: fontSize.w / 1.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          'Delivery in minutes',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        CustomText(
                                          maxLines: 2,
                                          locationProvider.fullAddress ?? '',
                                          fontSize: 12,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/userIcon.png',
                          height: 33,
                          width: 33,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: fontSize.h * 0.02),
                SearchBar(),
                SizedBox(height: fontSize.h * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        getHomeData?.categoriesOnly?.length ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: fontSize.w / 5.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: CustomNetworkImage(
                                    borderRadius: 30,
                                    imageUrl:
                                        getHomeData
                                            ?.categoriesOnly?[index]
                                            .categoryTypeName ??
                                        "",
                                  ),
                                ),
                                SizedBox(height: fontSize.h * 0.01),
                                CustomText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  textAlign: TextAlign.center,
                                  getHomeData
                                          ?.categoriesOnly?[index]
                                          .categoryTypeName ??
                                      "",
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final List<String> searchHints = [
    "Search your every needs",
    'Search "Pet food"',
    'Search "Grocery"',
    'Search "Vegetables"',
    'Search "Fruits"',
    'Search "Milk & Bread"',
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();

    // Auto change text every 2 seconds
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return false;
      setState(() {
        _index = (_index + 1) % searchHints.length;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchItemScreen()),
        );
      },
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 25),
          enabled: false,
          // ❗ REMOVE hintText completely
          hintText: null,

          // ✅ Always show animated hint from start
          hint: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  searchHints[_index],
                  key: ValueKey(searchHints[_index]),
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.start, // optional
                ),
              ),
            ),
          ),

          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class AnimatedCategoryTabBar extends StatefulWidget {
  final List<CategoriesOnly> tabs;
  final ValueChanged<int> onChanged;

  const AnimatedCategoryTabBar({
    super.key,
    required this.tabs,
    required this.onChanged,
  });

  @override
  State<AnimatedCategoryTabBar> createState() => _AnimatedCategoryTabBarState();
}

class _AnimatedCategoryTabBarState extends State<AnimatedCategoryTabBar> {
  int selectedIndex = 0; // 0 = All

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);

    /// total = All + API categories
    final totalTabs = widget.tabs.length + 1;

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: totalTabs,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          final String title;
          final String image;
          final bool isAll = index == 0;

          if (isAll) {
            title = "All";
            image = "assets/all_category.png";
          } else {
            final tab = widget.tabs[index - 1];
            title = tab.categoryTypeName ?? "";
            image = tab.image ?? "";
          }

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);

              if (isAll) {
                widget.onChanged(-1); // All
              } else {
                widget.onChanged(index - 1); // API index
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: isSelected ? 1.15 : 1.0,
                    child: isAll
                        ? Image.asset(
                            image,
                            height: 26,
                            width: 26,
                            color: isSelected ? Colors.white : Colors.white70,
                          )
                        : CustomNetworkImage(
                            imageUrl: image,
                            height: 26,
                            width: 26,
                          ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                    child: CustomText(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// bottom curved indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    height: isSelected ? 6 : 0,
                    width: isSelected ? 42 : 0,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
