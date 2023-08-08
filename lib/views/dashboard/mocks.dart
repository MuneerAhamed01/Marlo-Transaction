import 'package:flutter/material.dart';
import 'package:transactions/utils/flags.dart';
import 'package:transactions/views/dashboard/dashboard.dart';

List<CountryAndPounds> countryAndPoundsDashboard = [
  CountryAndPounds(Flags.canada, '18,585,625.89', 'Canadian dollar'),
  CountryAndPounds(Flags.us, '14,897,421.60', 'US dollar'),
  CountryAndPounds(Flags.uk, '15,256,486.00', 'British Pound'),
];

const String image4 =
    'assets/images/remember_me_FILL0_wght400_GRAD0_opsz48 1.svg';
List<GradientTileItem> gradientTileItems = [
  GradientTileItem(
    'assets/images/document_scanner_FILL0_wght400_GRAD0_opsz48 1.svg',
    'Verify your business documents',
    [
      const Color(0xff543290).withOpacity(.3),
      const Color(0xff543290).withOpacity(.0)
    ],
  ),
  GradientTileItem(
    "assets/images/remember_me_FILL0_wght400_GRAD0_opsz48 1.svg",
    'Verify your identity',
    [
      const Color(0xffFF9F0A).withOpacity(.3),
      const Color(0xffFF9F0A).withOpacity(.0)
    ],
  ),
  GradientTileItem(
    'assets/images/workspace_premium_FILL0_wght400_GRAD0_opsz48 1.svg',
    'Open a Marlo business account',
    [
      const Color(0xff00B3D7).withOpacity(.3),
      const Color(0xff00B3D7).withOpacity(.0)
    ],
  ),
  GradientTileItem(
    'assets/images/account_balance_FILL0_wght400_GRAD0_opsz48 1.svg',
    'Get prequalified',
    [
      const Color(0xff00CD21).withOpacity(.3),
      const Color(0xff00CD21).withOpacity(.0)
    ],
  )
];
