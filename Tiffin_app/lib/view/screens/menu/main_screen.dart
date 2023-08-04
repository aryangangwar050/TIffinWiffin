// ignore_for_file: missing_required_param

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/html_type.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/auth_provider.dart';
import 'package:flutter_grocery/provider/cart_provider.dart';
import 'package:flutter_grocery/provider/location_provider.dart';
import 'package:flutter_grocery/provider/profile_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/screens/address/address_screen.dart';
import 'package:flutter_grocery/view/screens/cart/cart_screen.dart';
import 'package:flutter_grocery/view/screens/category/all_category_screen.dart';
import 'package:flutter_grocery/view/screens/chat/chat_screen.dart';
import 'package:flutter_grocery/view/screens/coupon/coupon_screen.dart';
import 'package:flutter_grocery/view/screens/home/home_screen.dart';
import 'package:flutter_grocery/view/screens/html/html_viewer_screen.dart';
import 'package:flutter_grocery/view/screens/menu/widget/custom_drawer.dart';
import 'package:flutter_grocery/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:flutter_grocery/view/screens/profile/profile_screen.dart';
import 'package:flutter_grocery/view/screens/settings/setting_screen.dart';
import 'package:flutter_grocery/view/subscription/subscription_history.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final CustomDrawerController drawerController;
  MainScreen({this.drawerController});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _screens = [];
  List<String> _keys = [];
  List<String> _items = ["Privacy Policy", "Terms and Condition", "About us"];
  String selectedvalue;
  int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;

    final bool _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      Provider.of<LocationProvider>(context, listen: false)
          .initAddressList(context);
    } else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
    //ResponsiveHelper.isWeb() ? SizedBox() : NetworkInfo.checkConnectivity(context);

    _screens = [
      HomeScreen(),
      AllCategoryScreen(),
      CartScreen(),
      SubscriptionHistoryScreen(),
      AddressScreen(),
      CouponScreen(),
      ChatScreen(),
      SettingsScreen(),
      HtmlViewerScreen(htmlType: HtmlType.TERMS_AND_CONDITION),
      HtmlViewerScreen(htmlType: HtmlType.PRIVACY_POLICY),
      HtmlViewerScreen(htmlType: HtmlType.ABOUT_US),
    ];
    _keys = [
      'home',
      'all_categories',
      'shopping_bag',
      'sub_history',
      'address',
      'coupon',
      'live_chat',
      'settings',
      'terms_and_condition',
      'privacy_policy',
      'about_us',
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SplashProvider>(
      builder: (context, splash, child) {
        return WillPopScope(
          onWillPop: () async {
            if (splash.pageIndex != 0) {
              splash.setPageIndex(0);
              return false;
            } else {
              return true;
            }
          },
          child: Consumer<LocationProvider>(
            builder: (context, locationProvider, child) => Scaffold(
              appBar: ResponsiveHelper.isDesktop(context)
                  ? null
                  : AppBar(
                      backgroundColor: splash.pageIndex == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      actions: [
                        splash.pageIndex == 0
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  value: selectedvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedvalue = value as String;
                                      if (selectedvalue == _items[0]) {
                                        splash.setPageIndex(9);
                                      } else if (selectedvalue == _items[1]) {
                                        splash.setPageIndex(8);
                                      } else if (selectedvalue == _items[2]) {
                                        splash.setPageIndex(10);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  itemHeight: 34,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  dropdownMaxHeight: 200,
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width * 0.48,
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      // bottomRight: Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  dropdownElevation: 8,
                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 2,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(-20, 0),
                                  items: _items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Center(
                                              child: Text(
                                                item,
                                                textAlign: TextAlign.center,
                                                style: cerebriMedium.copyWith(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                      leading: splash.pageIndex == 0
                          ? IconButton(
                              icon: Container(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.67),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder(context),
                                      image:
                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/'
                                          '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel != null ? Provider.of<ProfileProvider>(context, listen: false).userInfoModel.image : ''}',
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60,
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(
                                              Images.placeholder(context),
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover),
                                    ),
                                  )),
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(),
                                      ));
                                });
                                // widget.drawerController.toggle();
                              })
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  splash.setPageIndex(0);
                                });
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).primaryColor,
                              )),
                      centerTitle: splash.pageIndex == 0 ? false : true,
                      title: splash.pageIndex == 0
                          ? Text(
                              "Welcome ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.fName}",
                              style: cerebriMedium.copyWith(
                                  fontSize:
                                      size.width > 360 && size.height > 700
                                          ? 20
                                          : 16),
                            )
                          : Text(
                              getTranslated(_keys[splash.pageIndex], context),
                              style: cerebriMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: Colors.black),
                            ),
                    ),
              body: _screens[splash.pageIndex],
              floatingActionButtonLocation: splash.pageIndex == 0
                  ? FloatingActionButtonLocation.centerDocked
                  : null,
              floatingActionButton: splash.pageIndex == 0
                  ? FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 1.5,
                      mini: false,
                      hoverElevation: 1.5,
                      shape: StadiumBorder(
                          side: BorderSide(
                              width: 0.5,
                              color: Theme.of(context).primaryColor)),
                      child: Image.asset(
                        Images.home,
                        width: 24,
                        height: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        splash.setPageIndex(0);
                        _pageIndex = 0;
                      },
                    )
                  : null,
              bottomNavigationBar: splash.pageIndex == 0
                  ? BottomAppBar(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      notchMargin: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: CircularNotchedRectangle(),
                      child: Padding(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Row(children: [
                          BottomNavItem(
                              iconData: Images.shopping_cart,
                              isSelected: _pageIndex == 1,
                              onTap: () {
                                splash.setPageIndex(2);
                                _pageIndex = 1;
                              }),
                          BottomNavItem(
                              iconData: Images.subscriptio_history,
                              isSelected: _pageIndex == 2,
                              onTap: () {
                                splash.setPageIndex(3);

                                _pageIndex = 0;
                              }),
                          Expanded(child: SizedBox()),
                          BottomNavItem(
                              iconData: Images.location,
                              isSelected: _pageIndex == 3,
                              onTap: () {
                                splash.setPageIndex(4);
                                _pageIndex = 3;
                              }),
                          BottomNavItem(
                              iconData: Images.log_out,
                              isSelected: _pageIndex == 4,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) =>
                                        SignOutConfirmationDialog());

                                _pageIndex = 4;
                              }),
                        ]),
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String iconData;
  final Function onTap;
  final bool isSelected;
  final bool float;
  BottomNavItem(
      {@required this.iconData,
      this.onTap,
      this.isSelected = false,
      this.float = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        icon: !isSelected && !float
            ? Image.asset(
                iconData,
                width: 24,
                height: 24,
                color: !float ? Colors.white : Theme.of(context).primaryColor,
              )
            : Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    )),
                child: Center(
                  child: Image.asset(
                    iconData,
                    width: 22,
                    height: 22,
                    color:
                        !float ? Colors.white : Theme.of(context).primaryColor,
                  ),
                ),
              ),
        // Icon(iconData, color: Colors.white, size: isSelected ? 30 : 25),
        onPressed: onTap,
      ),
    );
  }
}
