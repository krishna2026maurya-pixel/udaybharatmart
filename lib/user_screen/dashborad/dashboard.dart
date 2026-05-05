import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/session.dart';
import '../../empty_service.dart';
import '../../location_service/location_provider.dart';
import '../../location_service/update_item_location.dart';
import '../all_category/all_category_screen.dart';
import '../provider/view_model/home_provider.dart';
import '../widgets/cart_button_widget.dart';
import 'account/account_screen.dart';
import 'cart/cart_screen.dart';
import 'homePage/home_page.dart';
import 'package:in_app_update/in_app_update.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  bool _isBottomBarVisible = true;

  final List<Widget> _screens = const [
    HomePage(),
    AllCategoryScreen(),
    CartCheckoutScreen(),
    AccountScreen(),
  ];
  late LocationProvider locationProvider;
  String? usrId;
  @override
  void initState() {
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    Future.microtask(() async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      if (!homeProvider.hasLoadedOnce) {
        await homeProvider.homeApi(context).then((value) async {
          if(usrId!=''){
            return await homeProvider.userProfileApi(context);
          }
        });
        homeProvider.hasLoadedOnce = true;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cheForUpdate();
    });
    getUserId();
  }



  void getUserId() async {
    usrId = await MySharedPreferences.getUserId();
    setState(() {});
  }

  Future<void> cheForUpdate() async {
    print('Checking for update!');
    await InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        updateApp();
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
  void updateApp() async {
    await InAppUpdate.startFlexibleUpdate();
    await InAppUpdate.completeFlexibleUpdate().then((_) {
      print('App updated successfully!');
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap screens in NotificationListener to detect scroll
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          // Only hide/show bottom bar on HomePage scroll
          if (_currentIndex != 0) return false;

          final direction = notification.direction;
          if (direction == ScrollDirection.forward) {
            // Scroll up → show bottom bar
            if (!_isBottomBarVisible) setState(() => _isBottomBarVisible = true);
          } else if (direction == ScrollDirection.reverse) {
            // Scroll down → hide bottom bar
            if (_isBottomBarVisible) setState(() => _isBottomBarVisible = false);
          }
          return true;
        },
        child: _screens[_currentIndex],
      ),

      // Animated bottom navigation bar
      bottomNavigationBar: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: (_currentIndex == 0 ? _isBottomBarVisible : true)
              ? kBottomNavigationBarHeight
              : 0,
          child: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            if (!homeProvider.isLoading) {
              final getHomeData = homeProvider.userHomeRes.data;
              final bool isServiceAvailable = getHomeData != null &&
                  (getHomeData.categoriesOnly?.isNotEmpty ?? false) &&
                  (getHomeData.bestsellerVendorProducts?.isNotEmpty ?? false) &&
                  (getHomeData.categoriesWithProducts?.isNotEmpty ?? false);
              if (!isServiceAvailable) {
                return EmptyServiceView(
                  onChangeLocation: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const FractionallySizedBox(
                        heightFactor: 0.96,
                        child: SelectLocationBottomSheet(),
                      ),
                    );
                  },
                );
              }
            }

            return BottomNavigationBar(
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: AppColors.appColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                // Only require login for Cart & Account
                if (index == 2 || index == 3) {
                  if (usrId == null || usrId!.isEmpty) {
                    showLoginPrompt(context);
                    return;
                  }
                }
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/home.png',
                    height: 20,
                    color: _currentIndex == 0 ? AppColors.appColor : AppColors.grey,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/all_category.png',
                    height: 20,
                    color: _currentIndex == 1 ? AppColors.appColor : AppColors.grey,
                  ),
                  label: "Category",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/cartNav.png',
                    height: 20,
                    color: _currentIndex == 2 ? AppColors.appColor : AppColors.grey,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/userNav.png',
                    height: 20,
                    color: _currentIndex == 3 ? AppColors.appColor : AppColors.grey,
                  ),
                  label: "Account",
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
