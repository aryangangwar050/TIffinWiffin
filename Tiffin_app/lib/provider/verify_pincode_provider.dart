import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/base/api_response.dart';
import 'package:flutter_grocery/data/model/response/verify_pincode_model.dart';
import 'package:flutter_grocery/data/repository/verify_pinocde_repo.dart';
import 'package:flutter_grocery/helper/api_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PincodeVerifyProvider extends ChangeNotifier {
  final PincodeVerifyRepo verify;
  VerifyPincode _verifypincode;

  PincodeVerifyProvider({@required this.verify});
  VerifyPincode get verifypincode => _verifypincode;

  // ignore: missing_return
  Future<void> verifyPincode(
      BuildContext context, String pincode, String userid) async {
    ApiResponse apiResponse = await verify.verify(pincode, userid);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      if (apiResponse.response.data['message'] == "success") {
        _verifypincode = VerifyPincode.fromJson(apiResponse.response.data);
        //AppConstants.warehouse = _verifypincode.id.toString();
        Navigator.pop(context);
        // Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: apiResponse.response.data['city']);
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
