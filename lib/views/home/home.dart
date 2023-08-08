import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transactions/views/dashboard/dashboard.dart';
import 'package:transactions/views/home/home_controller.dart';

class Home extends GetWidget<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<HomeController>(builder: (_) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [const Dashboard(), _buildBottomBar()],
          ),
        );
      }),
    );
  }

  Container _buildBottomBar() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: controller.bottomNavigation.value,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home (1) 1.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/sack-dollar 1.svg'),
            label: 'Loans',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/file-invoice 1.svg'),
            label: 'Contracts',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/users-alt 1.svg'),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/comment-question 1.svg',
            ),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}
