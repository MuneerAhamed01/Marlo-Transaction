import 'package:get/get.dart';
import 'package:transactions/utils/source_type.dart';
import 'package:transactions/views/transactions/model/transaction_model.dart';

import '../data/transaction_repostiory.dart';

class TransactionController extends GetxController {
  final _transactionService = Get.find<TransactionRepository>();
  static const buildTransactionList = 'buildTransactionList';
  List<TransactionModel>? transactions;
  List<TransactionModel>? filteredList;
  bool get hasData => !isLoading && transactions != null;
  bool isLoading = false;
  Map<Filtering, dynamic> filter = {};

  _getTransactions() async {
    isLoading = true;
    update([buildTransactionList]);
    transactions = await _transactionService.getTransaction();
    isLoading = false;
    update([buildTransactionList]);
  }

  List<TransactionModel>? _moneyInOut(String type) {
    List<TransactionModel>? moneyFilter;
    if (type == 'Money in') {
      moneyFilter = transactions?.where((element) {
        return SourceTypeService.instance.moneyIn.contains(element.sourceType);
      }).toList();
    } else if (type == 'Money out') {
      moneyFilter = transactions?.where((element) {
        return SourceTypeService.instance.moneyOut.contains(element.sourceType);
      }).toList();
    } else if (type == 'Conversion') {
      moneyFilter = transactions?.where((element) {
        return element.sourceType == SourceType.conversion;
      }).toList();
    }
    if (moneyFilter != null) filter[Filtering.sourceType] = type;
    return moneyFilter;
  }

  List<TransactionModel>? _filteredStatus(String status) {
    List<TransactionModel>? filter;
    filter = transactions
        ?.where((element) => element.status == status.toUpperCase())
        .toList();
    if (filter != null) this.filter[Filtering.status] = status;
    return filter;
  }

  List<TransactionModel>? _filterMinAndMax(int? min, int? max) {
    List<TransactionModel>? filter;
    filter = transactions
        ?.where((element) =>
            (min ?? 0) <= double.parse(element.amount.replaceAll(',', '')) &&
            (double.parse(element.amount.replaceAll(',', '')) <=
                (max ?? double.infinity)))
        .toList();
    if (filter != null) this.filter[Filtering.amount] = [min, max];

    return filter;
  }

  filterAll() {
    final sourceType = filter[Filtering.sourceType];
    final status = filter[Filtering.status];
    final min = (filter[Filtering.amount] as List?)?[0];
    final max = (filter[Filtering.amount] as List?)?[1];
    filteredList = transactions;
    if (sourceType != null) {
      filteredList = filteredList!
          .toSet()
          .intersection(_moneyInOut(sourceType)?.toSet() ?? {})
          .toList();
    }
    if (status != null) {
      filteredList = filteredList!
          .toSet()
          .intersection(_filteredStatus(status)?.toSet() ?? {})
          .toList();
      print(filteredList);
    }
    if (min != null || max != null) {
      filteredList = filteredList!
          .toSet()
          .intersection(_filterMinAndMax(min, max)?.toSet() ?? {})
          .toList();
      print(filteredList);
    }
    print(filteredList);
    update([buildTransactionList]);
  }

  clear() {
    filter.clear();
    filteredList = null;
  }

  @override
  void onInit() {
    super.onInit();
    _getTransactions();
  }
}

enum Filtering { sourceType, timeRange, status, amount, currency }
