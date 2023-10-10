import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
class RatingStar extends StatefulWidget {
  const RatingStar({Key? key})
      : super(key: key);

  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    int value = 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return InkWell(
          onTap: (){
            value = (value  + 1);
            setState(() {

            });
          },
          child: Icon(
            index < value ? Icons.star : Icons.star_border,
            size: 8,
            color: index < value ? ColorResources.GREEN : null,
          ),
        );
      }),
    );
  }
}