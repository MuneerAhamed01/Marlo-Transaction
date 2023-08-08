import 'package:get/get.dart';
import 'package:transactions/views/home/home.dart';
import 'package:transactions/views/home/home_bindings.dart';
import 'package:transactions/views/transactions/getx/transaction_bindings.dart';
import 'package:transactions/views/transactions/transaction.dart';

class Routes {
  Routes._();
  static Routes instance = Routes._();
  List<GetPage> routes() => [
        GetPage(
          name: HomeBindings.homeRoute,
          binding: HomeBindings(),
          page: () => const Home(),
        ),
        GetPage(
          name: TransactionPage.transactionPath,
          binding: TransactionBindings(),
          page: () => const TransactionPage (),
        ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
        //   GetPage(
        //   name: RoutesName.initialRoute,
        //   page: () => const LandingPage(),
        //   binding: LandingPageBindings(),
        // ),
      ];

  // @override
  // String get initialRoute => ChessBoard.chessBoardPage;
}
