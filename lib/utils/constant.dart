class ApiConstant{
 static String BASE_URL="http://ec2-3-111-144-125.ap-south-1.compute.amazonaws.com:8080/crm/";
 static String SAVE_EMP=BASE_URL+"Employee/save";
 static String GET_ALL_LEAD=BASE_URL+"api/Lead/getAll";
 static String SAVE_LEAD=BASE_URL+"api/Lead/save";
 static String LOGIN_DATA=BASE_URL+"Login";
 static String LEAD_DELTEB=BASE_URL+"api/Lead/deleteById";
static String EMP_DELTEB=BASE_URL+"Employee/deleteById";

static String GET_ALL_ROLES=BASE_URL+"api/Role/getAll";

static String GET_ALL_EMPLOYEE=BASE_URL+"Employee/getAll";

static String CREATE_MEETING=BASE_URL+"api/Meetings2/save/withemail";


static String SAVE_LEAD_UPDATe=BASE_URL+"api/LeadUpdate/saveCustomer";

static String GET_ACTIVITY(id) =>BASE_URL+"api/LeadUpdate/getByLeadId?lead=$id";

static String GET_LEAD_METTING(id) =>BASE_URL+"api/Meetings2/getByLeadId?LeadId=$id";

static String GET_EMPLOYE_ALL_METTING(id) =>BASE_URL+"api/Meetings2/getByEmployeeId?employeeID=1";

 static String ASSIGN_PROJECT(id) =>BASE_URL+"api/Lead/getByleadAssignedToId?leadAssignedTo=$id";










}