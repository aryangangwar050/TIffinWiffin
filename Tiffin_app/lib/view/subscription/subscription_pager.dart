// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/app_bar_base.dart';
import 'package:flutter_grocery/view/base/custom_app_bar.dart';
import 'package:flutter_grocery/view/base/custom_bottomsheet.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/subscription/widget/scaled_list.dart';

class SubscriptionPagerScreen extends StatefulWidget {
  SubscriptionPagerScreen({Key key}) : super(key: key);

  @override
  State<SubscriptionPagerScreen> createState() =>
      _SubscriptionPagerScreenState();
}

class _SubscriptionPagerScreenState extends State<SubscriptionPagerScreen>
    with TickerProviderStateMixin {
  final globalKey = GlobalKey<ScaffoldState>();

  AnimationController bottomsheetcontrooler;

  @override
  void initState() {
    super.initState();
    bottomsheetcontrooler = BottomSheet.createAnimationController(this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      appBar: ResponsiveHelper.isMobilePhone()
          ? CustomAppBar(
              title: "Choose Your Plan",
              isBackButtonExist: true,
              isCenter: true,
              isElevation: true,
            )
          : ResponsiveHelper.isDesktop(context)
              ? PreferredSize(
                  child: WebAppBar(), preferredSize: Size.fromHeight(120))
              : AppBarBase(),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: ScaledList(
              itemCount: categories.length,
              showDots: true,
              marginWidthRatio:
                  size.width > 360 && size.height > 700 ? 0.055 : 0.075,
              cardWidthRatio:
                  size.width > 360 && size.height > 700 ? 0.78 : 0.62,
              selectedCardHeight: size.width > 360 && size.height > 700
                  ? size.height / 1.5
                  : size.height / 1.4,
              unSelectedCardHeight: size.width > 360 && size.height > 700
                  ? size.height / 1.7
                  : size.height / 1.6,
              itemColor: (index) {
                return Theme.of(context).primaryColor;
              },
              itemBuilder: (index, selectedIndex) {
                final category = categories[index];
                return Container(
                  // height: 800,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 28.0, top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                          child: Center(
                              child: Image.asset(
                            Images.in_sta_gram_icon,
                            width: 80,
                            height: 80,
                          )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          category.name,
                          style: cerebriMedium.copyWith(
                            fontSize:
                                size.width > 360 && size.height > 700 ? 28 : 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "A plan which provides you meals for 5 working days!",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: cerebriRegular.copyWith(
                              fontSize: size.width > 360 && size.height > 700
                                  ? 18
                                  : 14,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Secure your food problems for a whole week!",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: cerebriRegular.copyWith(
                              fontSize: size.width > 360 && size.height > 700
                                  ? 18
                                  : 14,
                              color: Color(0xFFE6FFFFFF)),
                        ),
                        Text(
                          "(Cancellations cannot be made on same day)",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: cerebriRegular.copyWith(
                              fontSize: size.width > 360 && size.height > 700
                                  ? 18
                                  : 14,
                              color: Color(0xFFCCFFFFFF)),
                        ),
                        SizedBox(
                          height:
                              size.width > 360 && size.height > 700 ? 20 : 5,
                        ),
                        TextButton(
                            onPressed: () {
                              showCustomBottomsheet(
                                  index, context, bottomsheetcontrooler,
                                  isCalender: true);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: size.width > 360 && size.height > 700
                                  ? EdgeInsets.only(top: 12, bottom: 12)
                                  : EdgeInsets.only(top: 10, bottom: 10),
                              margin: EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Choose this plan",
                                      style: cerebrisemibold.copyWith(
                                          fontSize: size.width > 360 &&
                                                  size.height > 700
                                              ? 16
                                              : 14,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  final List<Card> categories = [
    Card(name: "Daily"),
    Card(name: "Weekly"),
    Card(name: "Monthly"),
  ];
}

class Card {
  final String name;

  Card({@required this.name});
}
