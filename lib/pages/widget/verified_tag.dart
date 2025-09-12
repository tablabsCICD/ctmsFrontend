import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../organization_portal/util/app_constant.dart';
import '../../utils/colors.dart';

class VerifiedTag {
  onVeriedTag() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          border: Border.all(
            width: 0.5,
            color: ThemeColor.red,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Verified',
              style: TextStyle(
                  color: ThemeColor.theme_blue, // Customize text color
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                  fontFamily: AppConstant.FONTFAMILY),
            ),
          ],
        ),
      ),
    );
  }
}
