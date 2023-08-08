import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transactions/utils/styles.dart';
import 'package:transactions/views/transactions/getx/transaction_controller.dart';
import 'package:transactions/views/widgets/filter_bottom_sheet.dart';
import 'package:transactions/views/widgets/transaction_tile.dart';

class TransactionPage extends GetWidget<TransactionController> {
  const TransactionPage({super.key});
  static String transactionPath = '/transaction';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<TransactionController>(
            id: TransactionController.buildTransactionList,
            builder: (_) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.hasData) {
                return _buildLayout(context);
              }
              return const Center(child: Text('Error'));
            }),
      ),
    );
  }

  Widget _buildLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(),
            const SizedBox(height: 10),
            Text(
              'Transactions',
              style: Styles.notoSans
                  .copyWith(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _textField(),
                const SizedBox(width: 8),
                _filterIcon(context)
              ],
            ),
            const SizedBox(height: 32),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: _buildTransaction,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: controller.filteredList?.length ??
                  controller.transactions!.length,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _filterIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => FilterBottomList.showBottomSheet(context),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: const Color(0xffE9EEF0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(
            Icons.filter_alt,
            size: 16,
            color: Color(0xff768089),
          ),
        ),
      ),
    );
  }

  Expanded _textField() {
    return Expanded(
      child: SizedBox(
        height: 32,
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 10, left: 16),
            hintText: 'Search Vessel',
            hintStyle: Styles.notoSans
                .copyWith(color: const Color(0xffBBC9CD), fontSize: 12),
            fillColor: const Color(0xffE9EEF0),
            filled: true,
            border: _border(),
            focusedBorder: _border(),
            enabledBorder: _border(),
            errorBorder: _border(),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent));
  }

  Widget _appBar() {
    return Row(
      children: [
        IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios,
            // size: 40,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.file_download,
            // size: 40,
          ),
        )
      ],
    );
  }

  Widget _buildTransaction(BuildContext context, int index) {
    final transaction = controller.filteredList != null
        ? controller.filteredList![index]
        : controller.transactions![index];
    return TransactionTile(
      title: transaction.description,
      time: transaction.createdAt,
      amount: transaction.amount,
      currency: transaction.currency,
      icon: transaction.sourceType,
    );
  }
}
