import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/custom_popups.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/localization_provider.dart';
import 'package:flutter_grocery/provider/product_provider.dart';
import 'package:flutter_grocery/view/base/title_widget.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/screens/home/widget/banners_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/category_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
      reload,
    );
    Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(context, reload);
    // await Provider.of<ProductProvider>(context, listen: false).getDailyItemList(
    //   context,
    //   reload,
    //   Provider.of<LocalizationProvider>(context, listen: false)
    //       .locale
    //       .languageCode,
    // );

    // Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
    //     context,
    //     '1',
    //     true,
    //     Provider.of<LocalizationProvider>(context, listen: false)
    //         .locale
    //         .languageCode);
  }

  CustomPopups cp = new CustomPopups();

  @override
  void initState() {
    _loadData(context, false);
    // cp.pincode(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<ProductProvider>(context, listen: false).offset = 1;
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? PreferredSize(
                child: WebAppBar(), preferredSize: Size.fromHeight(120))
            : null,
        body: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                //Banner
                Consumer<BannerProvider>(builder: (context, banner, child) {
                  return banner.bannerList == null
                      ? BannersView()
                      : banner.bannerList.length == 0
                          ? SizedBox()
                          : BannersView();
                }),

                //category
                Consumer<CategoryProvider>(builder: (context, category, child) {
                  return category.categoryList == null
                      ? CategoryView()
                      : category.categoryList.length == 0
                          ? SizedBox()
                          : CategoryView();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
