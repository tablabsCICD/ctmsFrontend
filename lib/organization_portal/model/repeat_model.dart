import 'dart:convert';

import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';

class RepeatModel{
  final int? postId;
  final String? startDate,endDate,time;
  bool? isRepeat = false;

  RepeatModel(
  {this.postId, this.startDate, this.endDate, this.time, this.isRepeat});

  factory RepeatModel.fromJson(Map<String, dynamic> jsonData) {
    return RepeatModel(
      postId: jsonData['postId'],
      startDate: jsonData['startDate'],
      endDate: jsonData['endDate'],
      time: jsonData['time'],
      isRepeat: false,
    );
  }

  static Map<String, dynamic> toMap(RepeatModel repeatObj) => {
    'postId': repeatObj.postId,
    'startDate': repeatObj.startDate,
    'endDate': repeatObj.endDate,
    'time': repeatObj.time,
    'isRepeat': repeatObj.isRepeat,
  };

  static String encode(List<RepeatModel> repeatList) => json.encode(
    repeatList
        .map<Map<String, dynamic>>((repeatObj) => RepeatModel.toMap(repeatObj))
        .toList(),
  );

  static List<RepeatModel> decode(String repeatObj) =>
      (json.decode(repeatObj) as List<dynamic>)
          .map<RepeatModel>((item) => RepeatModel.fromJson(item))
          .toList();
}