import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hr_management/organization/util/style.dart';

class ConvertStringToDate extends StatelessWidget {
  final String? date;
  const ConvertStringToDate(this.date, {Key? key});

  @override
  Widget build(BuildContext context) {
    DateTime formatedDate = DateTime.parse(date!);
    print(formatedDate);
    var date1 = DateFormat("yyyy-MM-dd").format(formatedDate);
    var todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    if(date1 == todayDate){
       date1 = DateFormat("H:mm").format(formatedDate);
    }
    return Text(date1,
        style: Style.date);
  }
}