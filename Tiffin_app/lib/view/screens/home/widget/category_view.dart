import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/provider/theme_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/custom_bottomsheet.dart';
import 'package:flutter_grocery/view/base/title_widget.dart';
import 'package:flutter_grocery/view/screens/home/web/web_categories.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryView extends StatefulWidget {
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

AnimationController bottomsheetcontrooler;

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return category.categoryList != null
            ? Column(
                children: [
                  ResponsiveHelper.isDesktop(context)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(getTranslated('category', context),
                                style: cerebribold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                    color:
                                        ColorResources.getTextColor(context))),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TitleWidget(
                            title: getTranslated('category', context),
                          ),
                        ),
                  ResponsiveHelper.isDesktop(context)
                      ? CategoriesWebView()
                      : GridView.builder(
                          itemCount: 2,
                          // itemCount: category.categoryList.length > 5 ? 6 : category.categoryList.length,
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (1 / 1.4),
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showCustomBottomsheet(
                                    index, context, bottomsheetcontrooler,
                                    isMeal: true);
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.67),
                                    color: Colors.black87.withOpacity(0.8),
                                    boxShadow:
                                        Provider.of<ThemeProvider>(context)
                                                .darkTheme
                                            ? null
                                            : [
                                                BoxShadow(
                                                    offset: Offset(2, 2),
                                                    color: Colors.grey,
                                                    spreadRadius: 1,
                                                    blurRadius: 2)
                                              ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                          height: 300,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25.67),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  Images.placeholder(context),
                                              image:
                                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/${category.categoryList[index].image}',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset(
                                                      Images.placeholder(
                                                          context),
                                                      width: double.infinity,
                                                      fit: BoxFit.cover),
                                            ),
                                          )),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.67),
                                          color:
                                              Colors.black87.withOpacity(0.8),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          category.categoryList[index].name,
                                          style: cerebriMedium.copyWith(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                ],
              )
            : CategoryShimmer();
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      //physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (1 / 1.2),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(
                Provider.of<ThemeProvider>(context).darkTheme ? 0.05 : 1),
            boxShadow: Provider.of<ThemeProvider>(context).darkTheme
                ? null
                : [
                    BoxShadow(
                        color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
                  ],
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled:
                Provider.of<CategoryProvider>(context).categoryList == null,
            child: Column(children: [
              Expanded(
                flex: 6,
                child: Container(
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      vertical: Dimensions.PADDING_SIZE_LARGE),
                  child:
                      Container(color: Colors.grey[300], width: 50, height: 10),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
