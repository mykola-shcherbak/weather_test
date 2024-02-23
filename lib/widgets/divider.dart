import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.isHorizontal});
  final bool? isHorizontal;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double heigh = size.height * 0.01;
    final double width = size.width * 0.01;
    return isHorizontal == true
        ? SizedBox(
            width: width,
          )
        : SizedBox(
            height: heigh,
          );
  }
}
