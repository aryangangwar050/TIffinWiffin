
import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_grocery/data/model/response/base/api_response.dart';
import 'package:flutter_grocery/utill/app_constants.dart';

class PincodeVerifyRepo {
  final DioClient dioClient;

  PincodeVerifyRepo({@required this.dioClient});

  // ignore: missing_return
  Future<ApiResponse> verify(String pincode, String userid) async {
    try {
      final response = await dioClient
          .post('${AppConstants.PINCODE_VERIFY}?pincode=$pincode&user=$userid');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.data);
    }
  }
}