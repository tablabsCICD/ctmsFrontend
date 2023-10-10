import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/feedback_model.dart';
import 'package:flutter_hr_management/organization/model/gallary_model.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:flutter_hr_management/organization/model/load_model.dart';
import 'package:flutter_hr_management/organization/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization/model/repeat_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';

class RepeatProvider extends ChangeNotifier {
  List<RepeatModel> repeatPostList = [];
  var response;
  bool repeatFlag = false;

  setRepeatList(List<RepeatModel> repeatPostList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String encodedData = RepeatModel.encode(repeatPostList);
    await preferences.setString('AllRepeatPostList', encodedData);
  }

  Future<List<RepeatModel>> getRepeatList() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    final String? allRepeatePostList = await preferences.getString('AllRepeatPostList');
    final List<RepeatModel> repeat = RepeatModel.decode(allRepeatePostList!);
    return repeat;
  }


  addToRepeatList(TruckLoad? obj) async {
    repeatPostList.add(RepeatModel(postId: obj!.id, startDate: resFromDateCnt, endDate: resToDateCnt, time: TimeCnt, isRepeat: true));
    print("Length : "+repeatPostList.length.toString());
    resFromDateCnt = '';
    resToDateCnt = '';
    TimeCnt = '';

    setRepeatList(repeatPostList);
   /* final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = RepeatModel.encode(repeatPostList);
    await prefs.setString('AllRepeatPostList', encodedData);*/
    // Fetch and decode data
    notifyListeners();
  }

  final dashboardProvider = locator<DashboardProvider>();
  final authProvider = locator<AuthProvider>();

  checkRepeatTim() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? allRepeatePostList = await prefs.getString('AllRepeatPostList');
    final List<RepeatModel> repeat = RepeatModel.decode(allRepeatePostList!);
    print("repeat List : "+repeat.length.toString());
    DateTime now = DateTime.now();

    String minute = now.minute.toString();
    minute = minute.length == 1 ? "0$minute" : minute;

    String hour = now.hour.toString();
    hour = hour.length == 1 ? "0$hour" : hour;
    String currentTime = hour + " : " + minute;
    print("Current Time :"+currentTime);
    repeat.forEach((element) async {
      print("Repeat Time  :"+element.time.toString());
      DateTime startDate = DateTime.parse(element.startDate!);
      DateTime endDate = DateTime.parse(element.endDate!);
      if(startDate.isBefore(now)==true && endDate.isAfter(now)==true){
        if(currentTime == element.time.toString()){
          print('id'+element.postId.toString());
          Load load = await getFullLoadTruckById(element.postId!);
          print('object'+ load.transporterOrCustomerName.toString());
          dashboardProvider.savePost(
            mobile: authProvider.userDetailList[0].mobileNumber ,
            destination: load.destination,
            dnd: 0,
            email: authProvider.userDetailList[0].emailId,
            fullLoadChoice: load.fullLoadChoice,
            instruction: load.otherDetails,
            loadWeight: load.loadWeight,
            name: authProvider.userDetailList[0].userName,
            mainTag: load.mainTag,
            os: 'Web',
            otherDetails: load.otherDetails,
            source: load.source,
            partLoad: load.partLoad,
            privatePost: load.privatePost,
            rating: 5,
            customerName: '${authProvider.userDetailList[0].firstName} ${authProvider.userDetailList[0].lastName}',
            type: load.type,
            typeOfCargo: load.typeOfCargo,
            typeOfPayment: load.typeOfPayment,
            vehicleSize: load.vehicleSize,
          );
        }
      }

    });
    notifyListeners();
  }

  Timer? timer;
  startTimer(){
    if(timer== null) {
      timer = Timer.periodic(Duration(minutes: 1), (timer) {
        //checkRepeatTime();
      });
    }
  }

  stopTimer(){
    timer!.cancel();
  }

  Load? truckLoadObj;
  getFullLoadTruckById(int id) async {
    String myUrl = AppConstants.BASE_URL +'fullTruckLoad/${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    if(req.statusCode == 200) {
      response = json.decode(req.body);
      var type = LoadModel.fromJson(response);
      truckLoadObj = type.content[0];
      return truckLoadObj;
    }
  }


  String resFromDateCnt = "";
  String TimeCnt = "";
  String resToDateCnt = "";
  String? _hour, _minute, _time;
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime _date = DateTime.now();

  selectTime(BuildContext context, String timeString) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) selectedTime = picked;
    _hour = selectedTime.hour.toString();
    _minute = selectedTime.minute.toString();

    _hour = _hour!.length == 1 ? "0$_hour" : _hour;
    _minute = _minute!.length == 1 ? "0$_minute" : _minute;
    _time = _hour! + ' : ' + _minute!;

    if (picked?.periodOffset.toString() == '0') {
      TimeCnt = (_time).toString();
    } else if (picked?.periodOffset.toString() == '12') {
      TimeCnt = (_time).toString();
    }
    notifyListeners();
  }

  selectDate(BuildContext context, String controllerString) async {
    DateTime? _datePicker = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: _date,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      DateTime? date;

      if (controllerString == 'From Date') {
        if (_datePicker.isBefore(DateTime.now())) {
          date = _datePicker;
          resFromDateCnt = DateFormat('dd/MM/yyyy').format(DateTime.now());
          resToDateCnt = DateFormat('dd/MM/yyyy')
              .format(DateTime.now().add(Duration(days: 1)));
        } else {
          date = _datePicker;
          resFromDateCnt = DateFormat('dd/MM/yyyy').format(_datePicker);
          resToDateCnt = DateFormat('dd/MM/yyyy')
              .format(_datePicker.add(Duration(days: 1))); //resFromDateCnt;
        }
      } else if (controllerString == 'To Date') {
        if (_datePicker.isBefore(date!)) {
          resToDateCnt = DateFormat('dd/MM/yyyy').format(_datePicker);
        } else {
          resToDateCnt = DateFormat('dd/MM/yyyy').format(_datePicker);
        }
      }
      notifyListeners();
    }
    return _datePicker;
  }
}
