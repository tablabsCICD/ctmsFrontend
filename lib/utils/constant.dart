class ApiConstant {
 /* static String BASE_URL =
      "http://ec2-13-234-76-107.ap-south-1.compute.amazonaws.com:8080/crm/";*/
  static String BASE_URL = 'http://ec2-13-126-179-190.ap-south-1.compute.amazonaws.com:8080/ctms/';
  static String SAVE_EMP = BASE_URL + "Employee/save";
  static String EDIT_EMP = BASE_URL + "Employee/update";
  static String GET_ALL_LEAD = BASE_URL + "api/Lead/getAll";
  static String GET_ALL_CUSTMER = BASE_URL + "Customer/getAll";
  static String SAVE_LEAD = BASE_URL + "api/Lead/save";
  static String UPDATE_LEAD = BASE_URL + "api/Lead/update";
  static String LOGIN_DATA = BASE_URL + "Login";
  static String LEAD_DELTEB = BASE_URL + "api/Lead/deleteById";
  static String EMP_DELTEB = BASE_URL + "Employee/deleteById";
  static String GET_ALL_REPORT = BASE_URL + "CountAll/AllCountReport";
  static String GET_ALL_ROLES = BASE_URL + "api/Role/getAll";

  static String GET_ALL_EMPLOYEE = BASE_URL + "api/Employee/getAll";


  static String CREATE_MEETING = BASE_URL + "api/Meetings2/save/withemail";

  static String EDIT_MEETING = BASE_URL + "api/Meetings2/update";
  static String UPDATE_LEAD_STATUS = BASE_URL + "api/Lead/update/ByLeadIdAndStatus/customer";
  static String SAVE_LEAD_UPDATe = BASE_URL + "api/LeadUpdate/saveCustomer";
  static String UPLOAD_LEAD_IMG = BASE_URL + "api/UploadImage1";
  static String GET_ACTIVITY(id) =>
      BASE_URL + "api/LeadUpdate/getByLeadId?lead=$id";

  static String GET_LEAD_METTING(id) =>
      BASE_URL + "api/Meetings2/getByLeadId?LeadId=$id";

  static String GET_EMPLOYE_ALL_METTING(id) =>
      BASE_URL + "api/Meetings2/getByEmployeeId?employeeID=${id}";

  static String ASSIGN_PROJECT(id) =>
      BASE_URL + "api/Lead/getByleadAssignedToId?leadAssignedTo=$id";

  static String CREATE_MAIL = BASE_URL + "Employee/SendEmail";

  static String token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzd2F0aUBnbWFpbC5jb20iLCJleHAiOjE2OTg3ODE3MDYsImlhdCI6MTY5ODc0NTcwNn0.ZPMTIIh_-8Df7zBL89r0frmz_FoE7HANmDw3AgYGQ4M';
}
