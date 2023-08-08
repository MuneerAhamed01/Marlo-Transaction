import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transactions/utils/styles.dart';
import 'package:transactions/views/transactions/getx/transaction_controller.dart';
import 'package:transactions/views/widgets/filter_list.dart';

class FilterBottomList extends StatelessWidget {
  FilterBottomList._();
  static final List<String> _moneyInOut = [
    'Money in',
    "Money out",
    "Conversion"
  ];
  static final List<String> _status = ['Completed', "Pending", "Cancelled"];
  // static final List<String> _timeRange = [
  //   'Select range',
  //   'Today',
  //   "This week",
  //   "This month",
  //   'This quarter'
  // ];
  final _transactionController = Get.find<TransactionController>();
  static showBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      FilterBottomList._(),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: const BoxDecoration(
            color: Color(0xffF7F7F7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _pickingLine(),
              const SizedBox(height: 30),
              _filterAndClear(),
              const SizedBox(height: 20),
              FilterList(
                items: _moneyInOut,
                onPressed: (item) => _onTapFilter(item, Filtering.sourceType),
                title: 'Money in and out · 3',
                active: _transactionController.filter[Filtering.sourceType],
              ),
              const SizedBox(height: 32),
              FilterList(
                items: _status,
                onPressed: (item) => _onTapFilter(item, Filtering.status),
                title: 'Statuses · 3',
                active: _transactionController.filter[Filtering.status],
              ),
              const SizedBox(height: 32),
              // FilterList(
              //   items: _timeRange,
              //   onPressed: (item) {},
              //   title: 'Time range',
              // ),
              FilterList(
                maxAmount: (_transactionController.filter[Filtering.amount]
                    as List?)?[1],
                minAmount: (_transactionController.filter[Filtering.amount]
                    as List?)?[0],
                onChanged: (min, max) {
                  _transactionController.filter[Filtering.amount] = [min, max];
                },
                type: FilterListType.range,
                title: 'Amount',
              ),
              GestureDetector(
                onTap: Get.back,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffC6EBF6),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: Styles.notoSans.copyWith(
                        color: const Color(0xff0CABDF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _transactionController.filterAll();
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff0CABDF),
                  ),
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    'Apply',
                    style: Styles.notoSans.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  _onTapFilter(item, Filtering type) {
    if (_transactionController.filter[type] == item) {
      _transactionController.filter[type] = null;
      return;
    }
    _transactionController.filter[type] = item;
  }

  Widget _filterAndClear() {
    return Row(
      children: [
        Text(
          'Filter',
          style: Styles.notoSans
              .copyWith(fontSize: 34, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'Clear',
              style: Styles.notoSans.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(
                  0xff0CABDF,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _pickingLine() {
    return Center(
      child: Container(
        height: 5,
        width: 50,
        decoration: BoxDecoration(
            color: const Color(0xffC6EBF6),
            borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
