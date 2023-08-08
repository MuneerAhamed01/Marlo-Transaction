import 'package:get/get.dart';
import 'package:transactions/views/transactions/getx/transaction_controller.dart';

class TransactionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController());
  }
}
