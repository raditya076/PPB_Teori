import 'package:flutter/material.dart';
import '../models/banner_data.dart';

class BannerSlide extends StatelessWidget {
  final BannerData data;
  final double scale;
  const BannerSlide({super.key, required this.data, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset(
        data.imagePath,
        fit: BoxFit.cover,
      ),

      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              data.overlayColor.withValues(alpha: 0.50),
              data.overlayColor.withValues(alpha: 0.88),
            ],
          ),
        ),
      ),

      Positioned(
        right: 20 * scale,
        top: 0,
        bottom: 0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          Text(data.eyebrow,
              style: TextStyle(
                  color: data.accentColor.withValues(alpha: 0.9),
                  fontSize: 11 * scale,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 2 * scale),
          Text(data.percent,
              style: TextStyle(
                  color: data.accentColor,
                  fontSize: 46 * scale,
                  fontWeight: FontWeight.w800,
                  height: 1.0)),
          Text(data.suffix,
              style: TextStyle(
                  color: data.accentColor,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 4 * scale),
          Text(data.sub,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: data.accentColor.withValues(alpha: 0.75),
                  fontSize: 9 * scale)),
        ]),
      ),
    ]);
  }
}