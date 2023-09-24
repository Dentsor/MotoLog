import 'package:flutter/material.dart';

/// https://stackoverflow.com/a/54024767
class DashedSeparator extends StatelessWidget {
  const DashedSeparator(
      {super.key,
      this.height = 1,
      this.dashWidth = 10.0,
      this.color = Colors.black});

  final double height;
  final double dashWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final boxWidth = constraints.constrainWidth();
      final dashCount = (boxWidth / (2 * dashWidth)).floor();
      return Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: List.generate(dashCount, (_) {
          return SizedBox(
            width: dashWidth,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        },),
      );
    });
  }
}
