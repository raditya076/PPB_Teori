import 'package:flutter/material.dart';

class BannerData {
  final String imagePath, eyebrow, percent, suffix, sub;
  final Color overlayColor, accentColor;
  const BannerData({
    required this.imagePath,
    required this.overlayColor,
    required this.accentColor,
    required this.eyebrow,
    required this.percent,
    required this.suffix,
    required this.sub,
  });
}