import 'package:flutter/material.dart';

import '../../constants/asset_strings.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetStrings.logo,
      height: 180,
    );
  }
}
