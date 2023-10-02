import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height:475.h,
    //   width: 317.w,
    //   decoration: BoxDecoration(
    //       color: AppColor.white, borderRadius: BorderRadius.circular(10.r)),
    //   padding: EdgeInsets.all(10),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             "${DateFormat("MMM, yyyy").format(_focusedDay)}",
    //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
    //           ),
    //           Row(
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //                   setState(() {
    //                     _focusedDay =
    //                         DateTime(_focusedDay.year, _focusedDay.month - 1);
    //                   });
    //                 },
    //                 child: Icon(
    //                   Icons.chevron_left,
    //                   color: AppColor.black,
    //                 ),
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   setState(() {
    //                     _focusedDay =
    //                         DateTime(_focusedDay.year, _focusedDay.month + 1);
    //                   });
    //                 },
    //                 child: Icon(
    //                   Icons.chevron_right,
    //                   color: AppColor.black,
    //                 ),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 10.h,
    //       ),
    //       TableCalendar(
    //         onDaySelected: (datetime,date){
    //           _focusedDay=datetime;
    //           setState(() {
    //
    //           });
    //         },
    //        focusedDay: _focusedDay,
    //         firstDay: DateTime.utc(2010),
    //         lastDay: DateTime.utc(2040),
    //         headerVisible: false,
    //         onFormatChanged: (result) {},
    //         daysOfWeekStyle: DaysOfWeekStyle(
    //           dowTextFormatter: (date, locale) {
    //             return DateFormat("EEE").format(date).toUpperCase();
    //           },
    //           weekendStyle: TextStyle(fontWeight: FontWeight.bold),
    //           weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //         onPageChanged: (day) {
    //           _focusedDay = day;
    //           setState(() {});
    //         },
    //
    //         calendarStyle: CalendarStyle(
    //           todayDecoration: BoxDecoration(
    //             color: ThemeColor.red,
    //             shape: BoxShape.circle,
    //           ),
    //           markerDecoration: BoxDecoration(
    //             color: ThemeColor.red,
    //             shape: BoxShape.circle,
    //           ),
    //         ),
    //         eventLoader: (day) {
    //           if (day.day == 22 || day.day == 12|| day.day==15) {
    //             return [Event("Event Name", canBubble: true)];
    //           }
    //           return [];
    //         },
    //       )
    //     ],
    //   ),
    // );

    return getCalender();
  }



  CalendarFormat _calendarFormat = CalendarFormat.month;
 // DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  getCalender() {
    return Container(
      height: 424.h,
      width: 337.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: TableCalendar(
        headerVisible: true,
        daysOfWeekVisible: true,
        daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,fontFamily: GoogleFonts.poppins().fontFamily,),
          weekdayStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,)
        ),
        headerStyle: HeaderStyle(titleTextStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,fontFamily: GoogleFonts.poppins().fontFamily,),formatButtonVisible: false,),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,),
          weekendTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,),
          selectedTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,),
          selectedDecoration: BoxDecoration(color: ThemeColor.baground),
          rangeEndTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,),
          rangeStartTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,),
          todayTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,),
          outsideTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: Color(0xFFBFBFBF)),
          withinRangeTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: Color(0xFFBFBFBF)),
          disabledTextStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: Color(0xFFBFBFBF)),
        ),
        rowHeight: 40.h,
        firstDay: DateTime.utc(2010, 10, 20),
        lastDay: DateTime.utc(2040, 10, 20),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.
          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
