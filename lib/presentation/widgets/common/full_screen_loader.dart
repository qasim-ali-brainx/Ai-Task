import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import 'loaders.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.backgroundPrimary.withValues(alpha: 0.7),
      child: Center(child: Loaders.processingIndicator()),
    );
  }
}
