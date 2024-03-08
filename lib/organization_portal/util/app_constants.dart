

import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/model/language_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/auth_api.dart';

class AppConstants {

  static final String APP_VERSION="2.0.6";
 // static String BASE_URL = "https://api.tkdost.com/tkdConnect/api/"; //Production Url
  static String BASE_URL = "http://ec2-13-234-76-107.ap-south-1.compute.amazonaws.com:8080/tkd3/api/"; //Test Url
 // static String BASE_URL = "http://ec2-13-235-70-174.ap-south-1.compute.amazonaws.com:8080/tkdConnect/api/"; //Test Url
  static String LOGIN = BASE_URL + "authLogin/emailId";
  static String REGISTRATION = BASE_URL + "companyRegistration";
  static String GENERIC_DATA = BASE_URL + "/get/allCards";
  static String POST_JOB = BASE_URL + "/postJob";
  static String POST_FULL_LOAD = BASE_URL + "saveAndSendNotificaions";
  static String POST_EMPTY_LOAD = BASE_URL + "emptyTruckLoad";
  static String POST_BUY_SELL = BASE_URL + "buySell";
  static String GET_REMINDER = BASE_URL + "getReminders/save";
  static String PUT_REMINDER = BASE_URL + "getReminders/update";
  static String REMOVE_REMINDER = BASE_URL + "getReminders/userName/";
  static String LIST_REMINDER = BASE_URL + "getReminders/userName";
  static String GET_STATE = BASE_URL + "get/statesnew";
  static String GET_CITY = BASE_URL + "get/citynew";
  static String GET_OWNPOST = BASE_URL + "getOwnPost";
  static String REPORT_API = BASE_URL + "/complaint";
  static String CHAT_BACKUP = BASE_URL + "/chatBackup";
  static String OTP_VERIFICATION = BASE_URL + "verifyOTP";
  static String FORGOT_PASSWORD = BASE_URL + "forgotPassword";
  static String RESET_PASSWORD = BASE_URL + "resetPassword";
  static String LOGIN_USER_NAME = BASE_URL + "authLogin/userName";
  static String SAVING_RATING = BASE_URL + "saveRatings";
  static String PROFILE_PICUTURE = BASE_URL + "profilePicture";
  static String GET_CHAT_USER = BASE_URL + "getRatingsdateForUser/";
  static String GET_ALL_CITY = BASE_URL + "get/cities";
  static String GET_DISCUSSION = BASE_URL + "discussion";
  static String GET_COMMENTS = BASE_URL + "comments";
  static String ROUTE = BASE_URL + "preferredroutes";
  static String BULK_DATA = BASE_URL + "bulkBuySell";
  static String CITY_NEW_API = BASE_URL + "get/advanced/details";
  static String CITY_NEW_API_DB = BASE_URL + "/get/cities/db";
  static String SEND_MESSAGE = BASE_URL + "/sendGeneralSMS";
  static String GET_ALL_USER = BASE_URL + "/companyRegistration";

  static String SEND_OTP_ON_MAIL = BASE_URL + "SendOTPOnEmailId";
  static String VERIFY_OTP_ON_MAIL = BASE_URL + "verifyOTPEmail";
  static String SEND_OTP = BASE_URL + "SendOTP";
  static String ADD_CITY = BASE_URL + "/set/cities/db";
  static String DIRECTORY = BASE_URL + "directory";
  static String SHARE_POST_BASE_URL = "http://www.tkdost.com/tkd/";
  static String BID_TO_POST = BASE_URL + "biding";
  static String BID_FOR_USER = BASE_URL + "GetAllBidsForUser";
  static String POST_FIND_BY_ID = BASE_URL + "GetPostByIdAndType";
  static String BID_OWN_POST = BASE_URL + "GetPostsAndBidsForUser";
  static String CONTACT_LIST_BASED_ON_ROUTE = BASE_URL + "getListOfUsersBasedOnSourceAndDesination";
  static String SEND_NOTIFICATION = BASE_URL + "sendNotifications";
  static String POST_TRANSCATION = BASE_URL + "transactions";

  //-------New Api ---------
  static String FULL_LOAD_ALL_CARD = /*BASE_URL + */"https://api.tkdost.com/tkd2/api/allcards/fullLoad/andquery";
  static String JOBS_ALL_CARD = BASE_URL + "allCards/Jobs";
  static String BUY_SELL_ALL_CARD = BASE_URL + "allCards/buySell";
  static String LIKE_DISLIKE = BASE_URL + "discussionLikes";
  static String? FONTFAMILY=GoogleFonts.poppins().fontFamily;


  static String GALLERY = BASE_URL + "/Gallery";

 static String IMG_UPLOAD = BASE_URL +"uploadImages";
 static String COMPANY = BASE_URL + "CompanyDetails";
 static String GET_CURRENT_VERSION=BASE_URL+'GetLatestVaersion';

 static const String COUNTRY_CODE = 'country_code';
 static const String LANGUAGE_CODE = 'language_code';

 static  String GROUP=BASE_URL+'groups';
 static String GROUP_MEMBER_BULK=BASE_URL+'groupMembers/bulk';
 static String GROUP_BY_USER=BASE_URL+"groups/forUser/";
 static String GROUP_CHAT_MASSAGE=BASE_URL+'groups/chat/';
 static String SEND_GROUP_CHAT_MEASSAGE=BASE_URL+'save/chat';
 static String GROUP_MEMBER_LIST=BASE_URL+'groupMembers/byGroupId/';
 static String GROUP_MEMBER_DELETE=BASE_URL+'groupMembers?id=';
 static User USER_OBJECT=User();




  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en',isSelected: true),
    LanguageModel(imageUrl: '', languageName: 'हिंदी', countryCode: 'IN', languageCode: 'hi',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'मराठी', countryCode: 'IN', languageCode: 'mr',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'ಕನ್ನಡ', countryCode: 'IN', languageCode: 'kn',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'മലയാളം', countryCode: 'IN', languageCode: 'ml',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'తెలుగు', countryCode: 'IN', languageCode: 'te',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'தமிழ்', countryCode: 'IN', languageCode: 'ta',isSelected: false),
  ];
}
