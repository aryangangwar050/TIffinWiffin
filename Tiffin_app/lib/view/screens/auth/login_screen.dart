import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter_grocery/view/base/footer_view.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/screens/auth/signup_screen.dart';
import 'package:flutter_grocery/view/screens/menu/menu_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _emailFocus = FocusNode();
  FocusNode _numberFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GlobalKey<FormState> _formKeyLogin;
  bool email = true;
  bool phone = false;
  String _countryDialCode = '+880';

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserNumber() ??
            null;
    _passwordController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserPassword() ??
            null;
    _countryDialCode = CountryCode.fromCountryCode(
            Provider.of<SplashProvider>(context, listen: false)
                .configModel
                .country)
        .dialCode;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? PreferredSize(
              child: WebAppBar(), preferredSize: Size.fromHeight(120))
          : null,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Scrollbar(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: ResponsiveHelper.isDesktop(context)
                        ? MediaQuery.of(context).size.height - 560
                        : MediaQuery.of(context).size.height),
                child: SingleChildScrollView(
                  // padding: ResponsiveHelper.isDesktop(context)
                  //     ? EdgeInsets.all(0)
                  //     : EdgeInsets.all(0),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ResponsiveHelper.isDesktop(context)
                          ? SizedBox(
                              height: 30,
                            )
                          : SizedBox(),
                      Center(
                        child: Container(
                          width: _width > 700 ? 700 : _width,
                          padding: ResponsiveHelper.isDesktop(context)
                              ? EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 50)
                              : _width > 700
                                  ? EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL)
                                  : null,
                          decoration: _width > 700
                              ? BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 5,
                                        spreadRadius: 1)
                                  ],
                                )
                              : null,
                          child: Consumer<AuthProvider>(
                            builder: (context, authProvider, child) => Form(
                                key: _formKeyLogin,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                Images.app_logo,
                                                color:
                                                    Theme.of(context).cardColor,
                                                height:
                                                    ResponsiveHelper.isDesktop(
                                                            context)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4.5,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: size.width > 360 &&
                                                size.height > 700
                                            ? 6
                                            : 8,
                                        child: Container(
                                          width: _width,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                50,
                                              ),
                                              topLeft: Radius.circular(
                                                50,
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                Dimensions
                                                    .PADDING_SIZE_EXTRA_LARGE),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 20),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      getTranslated(
                                                          'welcome_back',
                                                          context),
                                                      style: cerebrisemibold
                                                          .copyWith(
                                                              fontSize: 24,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),

                                                SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                Provider.of<SplashProvider>(
                                                            context,
                                                            listen: false)
                                                        .configModel
                                                        .emailVerification
                                                    ? CustomTextField(
                                                        hintText: getTranslated(
                                                            'demo_gmail',
                                                            context),
                                                        isShowBorder: true,
                                                        focusNode: _emailFocus,
                                                        nextFocus:
                                                            _passwordFocus,
                                                        controller:
                                                            _emailController,
                                                        inputType: TextInputType
                                                            .emailAddress,
                                                      )
                                                    : Column(children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 25,
                                                                  top: 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .cardColor,
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                blurRadius: 25,
                                                                offset:
                                                                    const Offset(
                                                                        0, 10),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  getTranslated(
                                                                      'phone_number',
                                                                      context),
                                                                  style: cerebriRegular
                                                                      .copyWith(
                                                                          color:
                                                                              ColorResources.Black_COLOR),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 33,
                                                                child: TextFormField(
                                                                    focusNode:
                                                                        _numberFocus,
                                                                    enabled:
                                                                        true,
                                                                    controller:
                                                                        _emailController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .phone,
                                                                    cursorColor:
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                    decoration: InputDecoration(
                                                                        hintText: getTranslated(
                                                                            'number_hint',
                                                                            context),
                                                                        hintStyle: TextStyle(
                                                                            color: ColorResources.getHintColor(
                                                                                context)),
                                                                        border:
                                                                            InputBorder.none)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ]),

                                                SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_LARGE),

                                                SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 25, top: 5),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 25,
                                                        offset:
                                                            const Offset(0, 10),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          getTranslated(
                                                              'password',
                                                              context),
                                                          style: cerebriRegular.copyWith(
                                                              color: ColorResources
                                                                  .getHintColor(
                                                                      context)),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 33,
                                                        child: TextFormField(

                                                            // isShowBorder: true,
                                                            // isPassword: true,
                                                            // isShowSuffixIcon: true,
                                                            obscureText: true,
                                                            focusNode:
                                                                _passwordFocus,
                                                            controller:
                                                                _passwordController,
                                                            enabled: true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            cursorColor: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    getTranslated(
                                                                        'password_hint',
                                                                        context),
                                                                border:
                                                                    InputBorder
                                                                        .none)
                                                            // inputAction:
                                                            //     TextInputAction.done,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),

                                                // for remember me section
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        authProvider
                                                            .toggleRememberMe();
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 18,
                                                              height: 18,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: authProvider.isActiveRememberMe
                                                                    ? Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                    : ColorResources
                                                                        .getCardBgColor(
                                                                            context),
                                                                border: Border.all(
                                                                    color: authProvider.isActiveRememberMe
                                                                        ? Colors
                                                                            .transparent
                                                                        : Theme.of(context)
                                                                            .primaryColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                              child: authProvider
                                                                      .isActiveRememberMe
                                                                  ? Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 17)
                                                                  : SizedBox
                                                                      .shrink(),
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .PADDING_SIZE_SMALL),
                                                            Text(
                                                              getTranslated(
                                                                  'remember_me',
                                                                  context),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline2
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .FONT_SIZE_EXTRA_SMALL,
                                                                      color: ColorResources
                                                                          .getHintColor(
                                                                              context)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    authProvider.loginErrorMessage
                                                                .length >
                                                            0
                                                        ? CircleAvatar(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                            radius: 5)
                                                        : SizedBox.shrink(),
                                                    SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        authProvider
                                                                .loginErrorMessage ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2
                                                            .copyWith(
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_SMALL,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                // for login button
                                                SizedBox(height: 10),
                                                !authProvider.isLoading
                                                    ? CustomButton(
                                                        buttonText:
                                                            getTranslated(
                                                                'login',
                                                                context),
                                                        onPressed: () async {
                                                          String _email =
                                                              _emailController
                                                                  .text
                                                                  .trim();
                                                          if (!Provider.of<
                                                                      SplashProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .configModel
                                                              .emailVerification) {
                                                            _email =
                                                                _countryDialCode +
                                                                    _emailController
                                                                        .text
                                                                        .trim();
                                                          }
                                                          String _password =
                                                              _passwordController
                                                                  .text
                                                                  .trim();
                                                          if (_email.isEmpty) {
                                                            if (Provider.of<
                                                                        SplashProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .configModel
                                                                .emailVerification) {
                                                              showCustomSnackBar(
                                                                  getTranslated(
                                                                      'enter_email_address',
                                                                      context),
                                                                  context);
                                                            } else {
                                                              showCustomSnackBar(
                                                                  getTranslated(
                                                                      'enter_phone_number',
                                                                      context),
                                                                  context);
                                                            }
                                                          } else if (Provider.of<
                                                                          SplashProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .configModel
                                                                  .emailVerification &&
                                                              EmailChecker
                                                                  .isNotValid(
                                                                      _email)) {
                                                            showCustomSnackBar(
                                                                getTranslated(
                                                                    'enter_valid_email',
                                                                    context),
                                                                context);
                                                          } else if (_password
                                                              .isEmpty) {
                                                            showCustomSnackBar(
                                                                getTranslated(
                                                                    'enter_password',
                                                                    context),
                                                                context);
                                                          } else if (_password
                                                                  .length <
                                                              6) {
                                                            showCustomSnackBar(
                                                                getTranslated(
                                                                    'password_should_be',
                                                                    context),
                                                                context);
                                                          } else {
                                                            authProvider
                                                                .login(_email,
                                                                    _password)
                                                                .then(
                                                                    (status) async {
                                                              if (status
                                                                  .isSuccess) {
                                                                if (authProvider
                                                                    .isActiveRememberMe) {
                                                                  authProvider.saveUserNumberAndPassword(
                                                                      _emailController
                                                                          .text,
                                                                      _password);
                                                                } else {
                                                                  authProvider
                                                                      .clearUserNumberAndPassword();
                                                                }
                                                                Navigator.pushNamedAndRemoveUntil(
                                                                    context,
                                                                    RouteHelper
                                                                        .menu,
                                                                    (route) =>
                                                                        false,
                                                                    arguments:
                                                                        MenuScreen());
                                                              }
                                                            });
                                                          }
                                                        },
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      )),

                                                // for create an account
                                                SizedBox(height: 20),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            RouteHelper.signUp,
                                                            arguments:
                                                                SignUpScreen());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          getTranslated(
                                                              'create_an_account',
                                                              context),
                                                          style: cerebriRegular.copyWith(
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_SMALL,
                                                              color: ColorResources
                                                                  .getHintColor(
                                                                      context)),
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        Text(
                                                          getTranslated(
                                                              'signup',
                                                              context),
                                                          style: cerebriMedium.copyWith(
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_SMALL,
                                                              color: ColorResources
                                                                  .getTextColor(
                                                                      context)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      ResponsiveHelper.isDesktop(context)
                          ? SizedBox(
                              height: 50,
                            )
                          : SizedBox(),
                      ResponsiveHelper.isDesktop(context)
                          ? FooterView()
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
