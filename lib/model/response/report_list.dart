class ReportModel {
  String? message;
  ReportData? data;
  bool? success;

  ReportModel({this.message, this.data, this.success});

  ReportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ReportData.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class ReportData {
  List<Customer>? customer;
  List<Employee>? employee;
  List<Lead>? lead;
  List<Quotation>? quotation;

  ReportData({this.customer, this.employee, this.lead, this.quotation});

  ReportData.fromJson(Map<String, dynamic> json) {
    if (json['customer'] != null) {
      customer = <Customer>[];
      json['customer'].forEach((v) {
        customer!.add(new Customer.fromJson(v));
      });
    }
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
    if (json['lead'] != null) {
      lead = <Lead>[];
      json['lead'].forEach((v) {
        lead!.add(new Lead.fromJson(v));
      });
    }
    if (json['quotation'] != null) {
      quotation = <Quotation>[];
      json['quotation'].forEach((v) {
        quotation!.add(new Quotation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.map((v) => v.toJson()).toList();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    if (this.lead != null) {
      data['lead'] = this.lead!.map((v) => v.toJson()).toList();
    }
    if (this.quotation != null) {
      data['quotation'] = this.quotation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? month;
  int? year;
  int? count;

  Customer({this.month, this.year, this.count});

  Customer.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['count'] = this.count;
    return data;
  }
}

class Employee {
  int? month;
  int? year;
  int? count;

  Employee({this.month, this.year, this.count});

  Employee.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['count'] = this.count;
    return data;
  }
}

class Lead {
  int? month;
  int? year;
  int? count;

  Lead({this.month, this.year, this.count});

  Lead.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['count'] = this.count;
    return data;
  }
}

class Quotation {
  int? month;
  int? year;
  int? count;

  Quotation({this.month, this.year, this.count});

  Quotation.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['count'] = this.count;
    return data;
  }
}

