import 'package:flutter/material.dart';

class RectangleSeparator extends StatelessWidget {
  const RectangleSeparator(
      {super.key, this.height = 1, this.color = Colors.black});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final boxWidth = constraints.constrainWidth();
      return Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          SizedBox(
            width: boxWidth,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          )
        ],
      );
    });
  }
}
