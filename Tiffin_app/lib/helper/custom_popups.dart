import 'package:flutter/material.dart';
import 'package:flutter_grocery/provider/profile_provider.dart';
import 'package:flutter_grocery/provider/verify_pincode_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class CustomPopups {
  Future<void> pincode(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), () {
      showDialog(
        barrierColor: Colors.black26,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
              elevation: 10,
              child: Consumer<PincodeVerifyProvider>(
                builder: (context, verify, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter your Area Pincode",
                          style: poppinsMedium.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 39,
                          ),
                          child: PinCodeTextField(
                            length: 6,
                            cursorColor: Theme.of(context).primaryColor,
                            appContext: context,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldHeight: 40,
                              fieldWidth: 40,
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(10),
                              selectedColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.2),
                              selectedFillColor: Theme.of(context).cardColor,
                              inactiveFillColor:
                                  ColorResources.getCardBgColor(context),
                              inactiveColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.2),
                              activeColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.4),
                              activeFillColor:
                                  ColorResources.getCardBgColor(context),
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            onChanged: (query) {
                              if (query.length == 6) {
                                String userid = Provider.of<ProfileProvider>(
                                        context,
                                        listen: false)
                                    .userInfoModel
                                    .id
                                    .toString();
                                verify.verifyPincode(context, query, userid);
                              }
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
        },
      );
    });
  }
}
