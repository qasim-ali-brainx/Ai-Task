import 'package:flutter/material.dart';

class Loaders {
  const Loaders._();

  static Widget processingIndicator() {
    return const SizedBox(
      width: 54,
      height: 54,
      child: CircularProgressIndicator(strokeWidth: 3),
    );
  }
}
