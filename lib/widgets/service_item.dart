import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final double scale;
  const ServiceItem(this.icon, this.color, this.label, this.scale, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(
            color: Colors.black.withValues(alpha: 0.06), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4 * scale,
            offset: Offset(0, 2 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: 10 * scale, horizontal: 6 * scale),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 50 * scale,
          height: 50 * scale,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14 * scale)),
          child: Icon(icon, size: 27 * scale, color: Colors.white),
        ),
        SizedBox(height: 7 * scale),
        Text(label,
            style: TextStyle(
                fontSize: 11 * scale,
                color: const Color(0xFF444444),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}