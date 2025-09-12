class CommonResponse {
  int? statusCode;
  String? message;
  bool? isSuccess;

  CommonResponse({this.statusCode, this.message, this.isSuccess});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;

    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

