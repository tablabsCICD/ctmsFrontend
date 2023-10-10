import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';

class CustomContainer extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final double? borderW;
  final double? cornerR;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  CustomContainer({
    this.color,
    this.borderColor,
    this.borderW,
    this.cornerR,
    this.width,
    this.height,
    this.alignment,
    this.child,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(cornerR ?? 0.0),
        border: Border.all(
          width: borderW != null ? 0: 0,
          color: borderColor != null ? Colors.transparent : ColorResources.PRIMARY_COLOR,
        ),
      ),
      child: Center(child: child),
    );
  }
}
