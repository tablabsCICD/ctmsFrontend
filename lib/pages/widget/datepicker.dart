import 'package:flutter/material.dart';

import '../../utils/date.dart';

class DateTimePickerDialog{
  late DateTime _selectedDate;
  Future<String> pickDateDialog(context) async{

    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return null;
      }
      _selectedDate=pickedDate;
    });
    if(_selectedDate!=null){
      return GetDateFormat.getFormatedDate(_selectedDate);
    }
    return "Select Date";
  }


  Future<String> selectTime(BuildContext context) async {

    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? picked =await showTimePicker(context: context, initialTime: initialTime);
    if (picked != null && picked != TimeOfDay.now() ){
     String time="${picked.hour}:${picked.minute}";
      return time;
    }

    return "Select Time";
  }


}