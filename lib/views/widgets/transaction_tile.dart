import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:transactions/utils/source_type.dart';
import 'package:transactions/utils/styles.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.title,
    required this.time,
    required this.amount,
    required this.icon,
    required this.currency,
  });
  final String title;
  final DateTime time;
  final String amount;
  final SourceType icon;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.isEmpty ? '- -' : title,
                  style: Styles.notoSans.copyWith(
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  _date(time),
                  style: Styles.notoSans.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff979797),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          _currency()
        ],
      ),
    );
  }

  String _date(DateTime time) {
    final format = DateFormat("E ·d MMM · h.mm a");
    String formattedDateTime = format.format(time);
    return formattedDateTime;
  }

  Text _currency() {
    Color? color;
    String text = amount.replaceAll('-', r'-$');
    if (!amount.contains('-')) {
      text = '+$currency$amount';
      color = Colors.green;
    }

    return Text(
      text,
      style: Styles.notoSans
          .copyWith(fontWeight: FontWeight.w400, fontSize: 12, color: color),
    );
  }

  SizedBox _buildIcon() {
    String svg;
    if (icon == SourceType.conversion) {
      svg = 'assets/images/Group 1000000849.svg';
    } else if (icon == SourceType.payout) {
      svg = 'assets/images/above_icon.svg';
    } else {
      svg = 'assets/images/Group 1000000849 (2).svg';
    }

    return SizedBox(
      height: 36,
      width: 36,
      child: SvgPicture.asset(svg),
    );
  }
}
