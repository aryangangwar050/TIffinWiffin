// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_grocery/helper/price_converter.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';

class SubscriptionHistoryScreen extends StatelessWidget {
  SubscriptionHistoryScreen({Key key}) : super(key: key);

  List<SubHistory> subs = [
    SubHistory(Images.placeholder_light, "Veg", "Weekly", 5, 200.00)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Now",
                style: cerebriMedium.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: 1,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    borderOnForeground: false,
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 73,
                                height: 73,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: Theme.of(context).primaryColor)),
                                child: Image.asset(
                                  subs[index].subimage,
                                  width: 73,
                                  height: 73,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Category",
                                          style: cerebriRegular.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          subs[index].category,
                                          style: cerebriMedium.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Plan",
                                          style: cerebriRegular.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          subs[index].plan,
                                          style: cerebriMedium.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Meal Count",
                                          style: cerebriRegular.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          subs[index].mealcount.toString(),
                                          style: cerebriMedium.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price",
                                  style: cerebrisemibold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  PriceConverter.convertPrice(
                                      context, subs[index].totalprice),
                                  style: cerebrisemibold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Last Subscribed",
                style: cerebriMedium.copyWith(
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    borderOnForeground: false,
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 73,
                                height: 73,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: Theme.of(context).primaryColor)),
                                child: Image.asset(
                                  subs[0].subimage,
                                  width: 73,
                                  height: 73,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Category",
                                          style: cerebriRegular.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          subs[0].category,
                                          style: cerebriMedium.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Plan",
                                          style: cerebriRegular.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          subs[0].plan,
                                          style: cerebriMedium.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Meal Count",
                                          style: cerebriRegular.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          subs[0].mealcount.toString(),
                                          style: cerebriMedium.copyWith(
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price",
                                  style: cerebrisemibold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  PriceConverter.convertPrice(
                                      context, subs[0].totalprice),
                                  style: cerebrisemibold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubHistory {
  final String subimage;
  final String category;
  final String plan;
  final int mealcount;
  final double totalprice;

  SubHistory(
    this.subimage,
    this.category,
    this.plan,
    this.mealcount,
    this.totalprice,
  );
}
