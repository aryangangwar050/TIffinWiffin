import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/userinfo_model.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/profile_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/images.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/custom_app_bar.dart';
import 'package:flutter_grocery/view/base/custom_text_field.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/screens/profile/web/profile_screen_web.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserInfoModel userInfoModel;

  ProfileEditScreen({this.userInfoModel});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  TextEditingController _confirmPasswordController;

  FocusNode firstNameFocus;
  FocusNode lastNameFocus;
  FocusNode emailFocus;
  FocusNode phoneFocus;
  FocusNode addressFocus;
  //FocusNode confirmPasswordFocus;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    // _confirmPasswordController = TextEditingController();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();
    phoneFocus = FocusNode();
    addressFocus = FocusNode();
    // confirmPasswordFocus = FocusNode();

    _firstNameController.text = widget.userInfoModel.fName ?? '';
    _lastNameController.text = widget.userInfoModel.lName ?? '';
    _emailController.text = widget.userInfoModel.email ?? '';
    _phoneController.text = widget.userInfoModel.phone ?? '';
    _addressController.text = widget.userInfoModel.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Theme.of(context).cardColor,
      appBar: ResponsiveHelper.isDesktop(context)
          ? PreferredSize(
              child: WebAppBar(), preferredSize: Size.fromHeight(120))
          : CustomAppBar(
              title: getTranslated("profile", context),
              isCenter: true,
              isElevation: true,
              isBackButtonExist: true,
            ),
      body: ResponsiveHelper.isDesktop(context)
          ? Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
              return ProfileScreenWeb(
                file: profileProvider.data,
                pickImage: profileProvider.pickImage,
                confirmPasswordController: _confirmPasswordController,
                confirmPasswordFocus: addressFocus,
                emailController: _emailController,
                firstNameController: _firstNameController,
                firstNameFocus: firstNameFocus,
                lastNameController: _lastNameController,
                lastNameFocus: lastNameFocus,
                emailFocus: emailFocus,
                passwordController: _addressController,
                passwordFocus: addressFocus,
                phoneNumberController: _phoneController,
                phoneNumberFocus: phoneFocus,
                image: widget.userInfoModel.image,
              );
            })
          : SafeArea(
              child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) => Scrollbar(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // for profile image
                            Container(
                              margin: EdgeInsets.only(top: 25, bottom: 24),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // border: Border.all(
                                //     color: ColorResources.getGreyColor(context),
                                //     width: 3),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (ResponsiveHelper.isMobilePhone()) {
                                    profileProvider.choosePhoto();
                                  } else {
                                    profileProvider.pickImage();
                                  }
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: profileProvider.file != null
                                          ? Image.file(profileProvider.file,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.fill)
                                          : profileProvider.data != null
                                              ? Image.network(
                                                  profileProvider.data.path,
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.fill)
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        Images.placeholder(
                                                            context),
                                                    width: 150,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                    image:
                                                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}'
                                                        '/${profileProvider.userInfoModel.image}',
                                                    imageErrorBuilder: (c, o,
                                                            s) =>
                                                        Image.asset(
                                                            Images.placeholder(
                                                                context),
                                                            height: 150,
                                                            width: 150,
                                                            fit: BoxFit.cover),
                                                  ),
                                                ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 15,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            //mobileNumber,email,gender
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for first name section
                                Stack(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
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
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getHintColor(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          CustomTextField(
                                            hintText: getTranslated(
                                                'enter_first_name', context),
                                            isElevation: false,
                                            isShowBorder: false,
                                            isPadding: false,
                                            controller: _firstNameController,
                                            focusNode: firstNameFocus,
                                            nextFocus: lastNameFocus,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //     bottom: 0,
                                    //     left: 20,
                                    //     right: 20,
                                    //     child: Divider()),
                                  ],
                                ),
                                SizedBox(height: 15),

                                // for Last name section
                                Stack(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
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
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getHintColor(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          CustomTextField(
                                            hintText: getTranslated(
                                                'enter_last_name', context),
                                            isElevation: false,
                                            isPadding: false,
                                            controller: _lastNameController,
                                            focusNode: lastNameFocus,
                                            nextFocus: emailFocus,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //     bottom: 0,
                                    //     left: 20,
                                    //     right: 20,
                                    //     child: Divider()),
                                  ],
                                ),
                                SizedBox(height: 15),
                                // for email section
                                Stack(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
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
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getHintColor(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          CustomTextField(
                                            hintText: getTranslated(
                                                'enter_email_address', context),
                                            isElevation: false,
                                            isPadding: false,
                                            isEnabled: false,
                                            controller: _emailController,
                                            focusNode: emailFocus,
                                            nextFocus: phoneFocus,
                                            inputType:
                                                TextInputType.emailAddress,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //     bottom: 0,
                                    //     left: 20,
                                    //     right: 20,
                                    //     child: Divider()),
                                  ],
                                ),
                                SizedBox(height: 15),
                                // for Phone Number section
                                Stack(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
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
                                              getTranslated('phone_number',
                                                      context) ??
                                                  '',
                                              style: cerebriRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getHintColor(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          CustomTextField(
                                            hintText: getTranslated(
                                                'enter_phone_number', context),
                                            isElevation: false,
                                            isPadding: false,
                                            controller: _phoneController,
                                            focusNode: phoneFocus,
                                            nextFocus: addressFocus,
                                            inputType: TextInputType.phone,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //     bottom: 0,
                                    //     left: 20,
                                    //     right: 20,
                                    //     child: Divider()),
                                  ],
                                ),
                                SizedBox(height: 15),

                                Stack(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
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
                                                      'address', context) ??
                                                  '',
                                              style: cerebriRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getHintColor(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          CustomTextField(
                                            hintText:
                                                "Enter your office address",
                                            isElevation: false,
                                            isPadding: false,
                                            isPassword: false,
                                            isShowSuffixIcon: false,
                                            controller: _addressController,
                                            focusNode: addressFocus,
                                            inputAction: TextInputAction.done,
                                            // nextFocus: confirmPasswordFocus,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //     bottom: 0,
                                    //     left: 20,
                                    //     right: 20,
                                    //     child: Divider()),
                                  ],
                                ),
                                SizedBox(height: 15),

                                // Stack(
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 20),
                                //           child: Text(
                                //             getTranslated('confirm_password',
                                //                     context) ??
                                //                 '',
                                //             style: cerebriRegular.copyWith(
                                //               fontSize: Dimensions
                                //                   .FONT_SIZE_EXTRA_SMALL,
                                //               color:
                                //                   ColorResources.getHintColor(
                                //                       context),
                                //             ),
                                //           ),
                                //         ),
                                //         CustomTextField(
                                //           hintText: getTranslated(
                                //               'password_hint', context),
                                //           isElevation: false,
                                //           isPadding: false,
                                //           isPassword: true,
                                //           isShowSuffixIcon: true,
                                //           controller:
                                //               _confirmPasswordController,
                                //           focusNode: confirmPasswordFocus,
                                //           inputAction: TextInputAction.done,
                                //         ),
                                //       ],
                                //     ),
                                //     Positioned(
                                //         bottom: 0,
                                //         left: 20,
                                //         right: 20,
                                //         child: Divider()),
                                //   ],
                                // ),
                              ],
                            ),

                            SizedBox(height: 25),
                            !profileProvider.isLoading
                                ? TextButton(
                                    onPressed: () async {
                                      // String _firstName =
                                      //     _firstNameController.text.trim();
                                      // String _lastName =
                                      //     _lastNameController.text.trim();
                                      // String _phoneNumber =
                                      //     _phoneController.text.trim();
                                      // String _password =
                                      //     _addressController.text.trim();
                                      // String _confirmPassword =
                                      //     _confirmPasswordController.text
                                      //         .trim();
                                      // if (profileProvider.userInfoModel.fName ==
                                      //         _firstName &&
                                      //     profileProvider.userInfoModel.lName ==
                                      //         _lastName &&
                                      //     profileProvider.userInfoModel.phone ==
                                      //         _phoneNumber &&
                                      //     profileProvider.userInfoModel.email ==
                                      //         _emailController.text &&
                                      //     profileProvider.file == null &&
                                      //     profileProvider.data == null &&
                                      //     _password.isEmpty &&
                                      //     _confirmPassword.isEmpty) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'change_something_to_update',
                                      //           context),
                                      //       context);
                                      // } else if (_firstName.isEmpty) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'enter_first_name', context),
                                      //       context);
                                      // } else if (_lastName.isEmpty) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'enter_last_name', context),
                                      //       context);
                                      // } else if (_phoneNumber.isEmpty) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'enter_phone_number', context),
                                      //       context);
                                      // } else if ((_password.isNotEmpty &&
                                      //         _password.length < 6) ||
                                      //     (_confirmPassword.isNotEmpty &&
                                      //         _confirmPassword.length < 6)) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'password_should_be', context),
                                      //       context);
                                      // } else if (_password !=
                                      //     _confirmPassword) {
                                      //   showCustomSnackBar(
                                      //       getTranslated(
                                      //           'password_did_not_match',
                                      //           context),
                                      //       context);
                                      // } else {
                                      //   UserInfoModel updateUserInfoModel =
                                      //       profileProvider.userInfoModel;
                                      //   updateUserInfoModel.fName =
                                      //       _firstNameController.text ?? "";
                                      //   updateUserInfoModel.lName =
                                      //       _lastNameController.text ?? "";
                                      //   updateUserInfoModel.phone =
                                      //       _phoneController.text ?? '';

                                      //   ResponseModel _responseModel =
                                      //       await profileProvider
                                      //           .updateUserInfo(
                                      //     updateUserInfoModel,
                                      //     _password,
                                      //     profileProvider.file,
                                      //     profileProvider.data,
                                      //     Provider.of<AuthProvider>(context,
                                      //             listen: false)
                                      //         .getUserToken(),
                                      //   );
                                      //   if (_responseModel.isSuccess) {
                                      //     profileProvider.getUserInfo(context);
                                      //     _addressController.text = '';
                                      //     _confirmPasswordController.text = '';
                                      //     showCustomSnackBar(
                                      //         getTranslated(
                                      //             'updated_successfully',
                                      //             context),
                                      //         context,
                                      //         isError: false);
                                      //   } else {
                                      //     showCustomSnackBar(
                                      //         _responseModel.message, context,
                                      //         isError: true);
                                      //   }
                                      //   setState(() {});
                                      // }
                                    },
                                    child: Container(
                                      height: 50,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Save Details",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Theme.of(context).primaryColor))),
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
