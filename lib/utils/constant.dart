import 'package:flutter_hr_management/utils/sharepreferences.dart';

class ApiConstant {

  static String BASE_URL = 'http://ec2-13-234-76-107.ap-south-1.compute.amazonaws.com:8080/ctmsOrg/';
 // static String BASE_URL = "https://api.tkdost.com/ctmsOrg/";
 // static String BASE_URL = "http://ec2-13-201-134-254.ap-south-1.compute.amazonaws.com:8080/tkd3/";
  static String BILTY_URL = 'http://builty2.0.s3-website.ap-south-1.amazonaws.com/builty';
  static String HRMS_URL = 'http://tkd-hrms.s3-website.ap-south-1.amazonaws.com/hrm';

  static String GET_CTMS_ORG = BASE_URL + 'api/Organisation/getById';
  static String GET_ALL_EMPLOYEE = BASE_URL + "api/Employee/getAllByFilter";
  static String SAVE_EMP = BASE_URL + "Employee/save";
  static String EDIT_EMP = BASE_URL + "api/Employee/update";
  static String EMP_DELTEB = BASE_URL + "api/Employee/deleteById?";
  static String SEARCH_EMP = BASE_URL + "api/search";
  static String DATEWISE_EMP_REPORT = BASE_URL +"api/getDetailedLeadReportWithEmployeeByEmployeeId";

  static String GET_ALL_LEAD = BASE_URL + "api/Lead/getAll";
  static String SAVE_LEAD = BASE_URL + "api/Lead/save";
  static String UPDATE_LEAD = BASE_URL + "api/Lead/update";
  static String LEAD_DELTEB = BASE_URL + "api/Lead/deleteById?";
  static String LEAD_SEARCH = BASE_URL + "api/Lead/getAll/byFilter";
  static String LEAD_BETWEEN_TWO_DATE = BASE_URL + "api/LeadDateBetween/getAll";
  static String UPDATE_LEAD_STATUS = BASE_URL + "api/Lead/update/ByLeadIdAndStatus/customer";
  static String SAVE_LEAD_UPDATe = BASE_URL + "api/LeadUpdate/saveCustomer";
  static String UPLOAD_LEAD_IMG = BASE_URL + "api/UploadImage1";
  static String UPLOAD_LEAD = BASE_URL + "api/upload/LeadFromXl";

  static String GET_ALL_SHORTLEAD = BASE_URL + "api/Lead/getAll/shortlead";
  static String UPLOAD_SHORTLEAD = BASE_URL + "api/upload/ShortLeadFromXl";

  static String GET_ALL_CUSTMER = BASE_URL + "Customer/getAll";
  static String SEARCH_CUSTMER = BASE_URL + "Customer/getAllByFilter";

  static String LOGIN_DATA = BASE_URL + "Login";
  static String GET_ALL_REPORT = BASE_URL + "CountAll/AllCountReport";
  static String GET_ALL_ROLES = BASE_URL + "api/Role/getAll";

  static String CREATE_MEETING = BASE_URL + "api/Meetings2/save/withemail";
  static String EDIT_MEETING = BASE_URL + "api/Meetings2/update";
  static String CANCEL_MEETING = BASE_URL + "api/Meetings2/cancle";


  static String GET_ACTIVITY(id) =>
      BASE_URL + "api/LeadUpdate/getByLeadId?lead=$id";
  static String GET_LEAD_METTING(id) =>
      BASE_URL + "api/Meetings2/getByLeadId?LeadId=$id";
  static String GET_EMPLOYE_ALL_METTING(id) =>
      BASE_URL + "api/Meetings2/getByEmployeeId?employeeID=${id}";

  static String ASSIGN_PROJECT(id) =>
  BASE_URL + "api/LeadUpdate/getByEmployeeFollowUpById?EmployeeName=$id";

  static String CREATE_MAIL = BASE_URL + "api/Employee/SendEmailRemainder";
  static String SEND_MAIL_CC = BASE_URL + "api/Employee/SendCCEmail";
//  static String token = '';
 // static String token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmdAZ21haWwuY29tIiwiZXhwIjoxNjk4ODc2MjQ5LCJpYXQiOjE2OTg4NDAyNDl9.VgbYGJ0Dgj3kwHXLxuWo_zZeJcxTs9R3I9zg-nhpnN8';



}
