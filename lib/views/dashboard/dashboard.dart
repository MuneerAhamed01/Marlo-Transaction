import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transactions/utils/source_type.dart';
import 'package:transactions/utils/styles.dart';
import 'package:transactions/views/dashboard/mocks.dart';
import 'package:transactions/views/transactions/transaction.dart';
import 'package:transactions/views/widgets/transaction_tile.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(),
            const SizedBox(height: 20),
            _countryAndPound(),
            const SizedBox(height: 32),
            _buildHeading('To do · 4'),
            const SizedBox(height: 20),
            _buildTODO(),
            const SizedBox(height: 32),
            Row(
              children: [
                _buildHeading('All transactions'),
                const Spacer(),
                TextButton(
                  onPressed: () => Get.toNamed(TransactionPage.transactionPath),
                  child: Text(
                    'See all',
                    style: Styles.notoSans.copyWith(
                      color: const Color(0xff0CABDF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 42),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: _buildTransaction,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransaction(BuildContext context, int index) {
    return TransactionTile(
        title: 'Rent', time: DateTime.now(), amount: '-00', icon: SourceType.conversion,currency: r'$',);
  }

  SizedBox _buildTODO() {
    return SizedBox(
      height: 122,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 16 : 0,
            right: countryAndPoundsDashboard.length == index ? 16 : 0,
          ),
          child: _GradientTile(
            svg: gradientTileItems[index].svg,
            text: gradientTileItems[index].title,
            gradient: gradientTileItems[index].color,
          ),
        ),
        separatorBuilder: _buildSeparator,
        itemCount: gradientTileItems.length,
      ),
    );
  }

  Padding _buildHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        text,
        style: Styles.notoSans.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xff768089),
        ),
      ),
    );
  }

  SizedBox _countryAndPound() {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildCountryPounds,
        separatorBuilder: _buildSeparator,
        itemCount: countryAndPoundsDashboard.length,
      ),
    );
  }

  Padding _buildCountryPounds(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 16 : 0,
        right: countryAndPoundsDashboard.length - 1 == index ? 16 : 0,
      ),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(countryAndPoundsDashboard[index].image),
              radius: 24,
            ),
            const SizedBox(height: 20),
            Text(
              countryAndPoundsDashboard[index].amount,
              style: Styles.notoSans.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(countryAndPoundsDashboard[index].country,
                style: Styles.notoSans.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff768089),
                )),
          ],
        ),
      ),
    );
  }

  SizedBox _buildSeparator(_, __) {
    return const SizedBox(width: 8);
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [_profileSection(), const Spacer(), _bellIcon()],
      ),
    );
  }

  SizedBox _bellIcon() {
    return const SizedBox(
      height: 24,
      width: 24,
      child: Icon(
        Icons.notifications,
        color: Color(0xff0CABDF),
      ),
    );
  }

  Container _profileSection() {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'JR',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _GradientTile extends StatelessWidget {
  const _GradientTile({
    required this.svg,
    required this.text,
    required this.gradient,
  });
  final String svg;
  final String text;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _backgroundGradient(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _svgPicture(),
        ),
      ],
    );
  }

  Container _svgPicture() {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [gradient.first.withOpacity(.2), Colors.transparent],
          )),
      child: SvgPicture.asset(svg),
    );
  }

  Container _backgroundGradient() {
    return Container(
      height: 122,
      width: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: gradient)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: Styles.notoSans.copyWith(
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CountryAndPounds {
  final String image;
  final String amount;
  final String country;

  CountryAndPounds(this.image, this.amount, this.country);
}

class GradientTileItem {
  final String svg;
  final String title;
  final List<Color> color;

  GradientTileItem(this.svg, this.title, this.color);
}
