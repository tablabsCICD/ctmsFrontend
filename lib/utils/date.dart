import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetDateFormat {

  static String formatDate="dd-MM-yyyy";


  static String getCurrentDate(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(formatDate).format(now);
    print('the format is $formattedDate');
    return formattedDate;

  }

  static String getFormatedDate(DateTime dateTime){
    DateTime now = dateTime;
    String formattedDate = DateFormat(formatDate).format(now);
    print('the format is $formattedDate');
    return formattedDate;

  }







}