import 'package:country_code_picker/country_code.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/signup_model.dart';
import 'package:flutter_grocery/helper/email_checker.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/auth_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/custom_button.dart';
import 'package:flutter_grocery/view/base/custom_snackbar.dart';
import 'package:flutter_grocery/view/base/custom_text_field.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/screens/menu/menu_screen.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _addressfocus = FocusNode();
  final FocusNode _dobfocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _dobcontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? PreferredSize(
              child: WebAppBar(), preferredSize: Size.fromHeight(120))
          : AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    Images.back_button,
                    color: Colors.white,
                    width: 84,
                    height: 84,
                  )),
              title: Text(
                "Signup",
                style: cerebriMedium.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // for first name section
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              getTranslated(
                                                  'first_name', context),
                                              style: cerebriRegular.copyWith(
                                                  color: ColorResources
                                                      .getHintColor(context)),
                                            )),
                                        Container(
                                          child: CustomTextField(
                                            hintText: 'John',
                                            isElevation: false,
                                            isShowBorder: false,
                                            isPadding: false,
                                            controller: _firstNameController,
                                            focusNode: _firstNameFocus,
                                            nextFocus: _lastNameFocus,
                                            inputType: TextInputType.name,
                                            capitalization:
                                                TextCapitalization.words,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE),
                                  // for last name section
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              getTranslated(
                                                  'last_name', context),
                                              style: cerebriRegular.copyWith(
                                                  color: ColorResources
                                                      .getHintColor(context)),
                                            )),
                                        CustomTextField(
                                          hintText: 'Doe',
                                          //isShowBorder: true,
                                          isElevation: false,
                                          isShowBorder: false,
                                          isPadding: false,
                                          controller: _lastNameController,
                                          focusNode: _lastNameFocus,
                                          nextFocus: _addressfocus,
                                          inputType: TextInputType.name,
                                          capitalization:
                                              TextCapitalization.words,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  CustomRadioButton(
                                    buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor:
                                          Theme.of(context).primaryColor,
                                      textStyle:
                                          cerebriMedium.copyWith(fontSize: 16),
                                    ),
                                    autoWidth: false,
                                    enableButtonWrap: true,
                                    wrapAlignment: WrapAlignment.center,
                                    unSelectedColor:
                                        Theme.of(context).canvasColor,
                                    buttonLables: [
                                      "Male",
                                      "Female",
                                    ],
                                    buttonValues: [
                                      "Male",
                                      "Female",
                                    ],
                                    defaultSelected: "Male",
                                    horizontal: false,
                                    width: 150,
                                    height: 40,
                                    elevation: 5,
                                    spacing: 20.0,
                                    selectedBorderColor:
                                        Theme.of(context).primaryColor,
                                    unSelectedBorderColor: Colors.white,
                                    selectedColor:
                                        Theme.of(context).colorScheme.secondary,
                                    padding: 15,
                                    enableShape: true,
                                    radioButtonValue: (Object) {
                                      print(Object);
                                    },
                                  ),

                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE),

                                  //for address section

                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              getTranslated('address', context),
                                              style: cerebriRegular.copyWith(
                                                  color: ColorResources
                                                      .getHintColor(context)),
                                            )),
                                        CustomTextField(
                                          hintText:
                                              'House no. 1, Street, City....',
                                          isElevation: false,
                                          isShowBorder: false,
                                          isPadding: false,
                                          controller: _addresscontroller,
                                          focusNode: _addressfocus,
                                          nextFocus: _emailFocus,
                                          inputType:
                                              TextInputType.streetAddress,
                                          capitalization:
                                              TextCapitalization.words,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE),
                                  // for email section
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              getTranslated('email', context),
                                              style: cerebriRegular.copyWith(
                                                  color: ColorResources
                                                      .getHintColor(context)),
                                            )),
                                        CustomTextField(
                                          hintText: getTranslated(
                                              'demo_gmail', context),
                                          isElevation: false,
                                          isShowBorder: false,
                                          isPadding: false,
                                          controller: _emailController,
                                          focusNode: _emailFocus,
                                          nextFocus: _dobfocus,
                                          inputType: TextInputType.emailAddress,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE),
                                  // for dob section
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: Offset(1, 1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "Date of Birth",
                                              style: cerebriRegular.copyWith(
                                                  color: ColorResources
                                                      .getHintColor(context)),
                                            )),
                                        CustomTextField(
                                          hintText: "dd/mm/yyyy",
                                          isElevation: false,
                                          isShowBorder: false,
                                          isPadding: false,
                                          controller: _dobcontroller,
                                          focusNode: _dobfocus,
                                          // nextFocus: _passwordFocus,
                                          inputType: TextInputType.datetime,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE),

                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      authProvider.registrationErrorMessage
                                                  .length >
                                              0
                                          ? CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              radius: 5)
                                          : SizedBox.shrink(),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          authProvider
                                                  .registrationErrorMessage ??
                                              "",
                                          style: cerebriRegular.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  // for signup button
                                  // SizedBox(height: 10),
                                  !authProvider.isLoading
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 40, right: 40),
                                          child: CustomButton(
                                            buttonText: getTranslated(
                                                'signup', context),
                                            onPressed: () {
                                              String _firstName =
                                                  _firstNameController.text
                                                      .trim();
                                              String _lastName =
                                                  _lastNameController.text
                                                      .trim();
                                              String _address =
                                                  _addresscontroller.text;
                                              String _dob =
                                                  _dobcontroller.text.trim();
                                              String _email =
                                                  _emailController.text.trim();
                                              // String _password =
                                              //     _passwordController.text
                                              //         .trim();
                                              // String _confirmPassword =
                                              //     _confirmPasswordController
                                              //         .text
                                              //         .trim();
                                              if (Provider.of<SplashProvider>(
                                                      context,
                                                      listen: false)
                                                  .configModel
                                                  .emailVerification) {
                                                if (_firstName.isEmpty) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_first_name',
                                                          context),
                                                      context);
                                                } else if (_lastName.isEmpty) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_last_name',
                                                          context),
                                                      context);
                                                } else if (_address.isEmpty) {
                                                  showCustomSnackBar(
                                                      "Enter Office Address",
                                                      context);
                                                } else if (_dob.isEmpty) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_phone_number',
                                                          context),
                                                      context);
                                                }
                                                // else if (_password
                                                //     .isEmpty) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'enter_password',
                                                //           context),
                                                //       context);
                                                // } else if (_password
                                                //         .length <
                                                //     6) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'password_should_be',
                                                //           context),
                                                //       context);
                                                // } else if (_confirmPassword
                                                //     .isEmpty) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'enter_confirm_password',
                                                //           context),
                                                //       context);
                                                // } else if (_password !=
                                                //     _confirmPassword) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'password_did_not_match',
                                                //           context),
                                                //       context);
                                                // }
                                                else {
                                                  SignUpModel signUpModel =
                                                      SignUpModel(
                                                    fName: _firstName,
                                                    lName: _lastName,
                                                    address: _address,
                                                    email: authProvider.email,
                                                    password: _dob,
                                                    phone: "",
                                                  );
                                                  // print("details => $signUpModel");
                                                  authProvider
                                                      .registration(signUpModel)
                                                      .then((status) async {
                                                    if (status.isSuccess) {
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              RouteHelper.menu,
                                                              (route) => false,
                                                              arguments:
                                                                  MenuScreen());
                                                    }
                                                  });
                                                }
                                              } else {
                                                if (_firstName.isEmpty) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_first_name',
                                                          context),
                                                      context);
                                                } else if (_lastName.isEmpty) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_last_name',
                                                          context),
                                                      context);
                                                } else if (_email.isEmpty) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_email_address',
                                                          context),
                                                      context);
                                                } else if (EmailChecker
                                                    .isNotValid(_email)) {
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'enter_valid_email',
                                                          context),
                                                      context);
                                                }
                                                //  else if (_password
                                                //     .isEmpty) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'enter_password',
                                                //           context),
                                                //       context);
                                                // }
                                                // else if (_password
                                                //         .length <
                                                //     6) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'password_should_be',
                                                //           context),
                                                //       context);
                                                // } else if (_confirmPassword
                                                //     .isEmpty) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'enter_confirm_password',
                                                //           context),
                                                //       context);
                                                // } else if (_password !=
                                                //     _confirmPassword) {
                                                //   showCustomSnackBar(
                                                //       getTranslated(
                                                //           'password_did_not_match',
                                                //           context),
                                                //       context);
                                                // }
                                                else {
                                                  SignUpModel signUpModel =
                                                      SignUpModel(
                                                    fName: _firstName,
                                                    lName: _lastName,
                                                    address: _address,
                                                    email: _email,
                                                    password: _dob,
                                                    phone: authProvider.email
                                                        .trim(),
                                                  );

                                                  authProvider
                                                      .registration(signUpModel)
                                                      .then((status) async {
                                                    if (status.isSuccess) {
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              RouteHelper.menu,
                                                              (route) => false,
                                                              arguments:
                                                                  MenuScreen());
                                                    }
                                                  });
                                                }
                                              }
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context)
                                                      .primaryColor),
                                        )),
                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                Positioned(
                    right: -5,
                    top: 0,
                    child: Image.asset(
                      Images.indian_meal,
                      width: 180,
                      height: 180,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
