import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: 15,
          color: index < value ? Color(0xffF4EA00) : null,
        );
      }),
    );
  }
}