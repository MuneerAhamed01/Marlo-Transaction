
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transactions/api/api_bindings.dart';
import 'package:transactions/views/transactions/model/transaction_model.dart';

class TransactionRepository extends GetxService {
  final GetConnect connect;
  static String successMessage = 'SUCCESS';

  TransactionRepository(this.connect);
  final _baseService = Get.find<BaseApiBindings>();

  //https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/v2/airwallex/995b1e2e-c5ac-417b-afe5-1de5e92f4cf3/transfers

  Future<List<TransactionModel>?> getTransaction() async {
    try {
      var headers = {'authToken': _baseService.token!};

      final response = await connect.get(
        'airwallex/995b1e2e-c5ac-417b-afe5-1de5e92f4cf3/transfers',
        headers: headers,
      );
      if (response.body['error_flag'] != successMessage) {
        _showError(response.body['message']);
        return null;
      }

      return (response.body['data'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    } catch (e) {
      _showError(e.toString());
      return null;
    }
  }


  _showError(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      backgroundColor: Colors.red,
      title: 'Something went wrong',
    ));
  }
}
