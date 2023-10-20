

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_dropdown_list.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization/base_widget/cutom_city_textfield.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization/dialog/CustomCityListDialog.dart';
import 'package:flutter_hr_management/organization/dialog/CustomStateListDialog.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization/provider/job_provider.dart';
import 'package:flutter_hr_management/organization/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';

class CreatePoolPurchasePost extends StatefulWidget {
  final poolPurchaseProvider = locator<PoolPurchaseProvider>();

  @override
  _CreatePoolPurchasePostState createState() => _CreatePoolPurchasePostState();
}

class _CreatePoolPurchasePostState extends State<CreatePoolPurchasePost> {
  String selectedPurchaseItem = 'Tyres';
  String selectedCondition = '';
  String selectedMakerName = '';
  String selectedVehicleSize = '';
  String selectedYear = '';
  String selectedCity = 'Pune';
  final _formKey = GlobalKey<FormState>();
  List<String> itemList = <String>['Vehicles',
    'Tyres',
    'Body Building',
    'Finance',
    'Insurance',
    'Other'];
  List<String> ctcList = List<String>.empty(growable: true);
  List<String> jobTypeList = List<String>.empty(growable: true);
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController modelName = TextEditingController();
  TextEditingController vehicleRno = TextEditingController();
  TextEditingController kiloMeter = TextEditingController();
  TextEditingController insuranceDate = TextEditingController();

  String purchaseDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  var _date = DateTime.now();
  _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: _date,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        purchaseDate = DateFormat('dd/MM/yyyy').format(_datePicker);
      });
    }
    return _datePicker;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<AuthProvider>(
        builder: (context, model, child) => Container(
          margin: ResponsiveWidget.isDesktop(context)? EdgeInsets.symmetric(horizontal: 50,vertical: 10):ResponsiveWidget.isMobile(context)?EdgeInsets.symmetric(horizontal: 0,vertical: 10):EdgeInsets.symmetric(horizontal: 100,vertical: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomDropdownList(
                hintText: "Select Purchase Item",
                items: itemList,
                selectedType: selectedPurchaseItem,
                onChange: (String value){
                  setState(() {
                    selectedPurchaseItem = value;
                  });
                },
              ),
              CustomTextField(
                hintText: 'Name',
                controller: TextEditingController(
                    text: model.userDetailList[0].firstName ?? ''),
                textInputType: TextInputType.text,
                readOnly: true,
              ),
              CustomTextField(
                hintText: 'Mobile',
                controller: TextEditingController(
                    text:
                    model.userDetailList[0].mobileNumber.toString()),
                textInputType: TextInputType.phone,
                readOnly: true,
              ),
              CustomTextField(
                hintText: 'Email',
                controller: TextEditingController(
                    text: model.userDetailList[0].emailId ?? ''),
                textInputType: TextInputType.emailAddress,
                readOnly: true,
              ),
              CustomCityTextField(
                hintText: 'Select City',
                controller: selectedCity,
                onTap: (){
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return CustomCityListDialog(
                            onTap : (String value){
                              setState(() {
                                selectedCity = value;
                              });
                            }
                        );
                      }
                  ) ;
                },
              ),
              CustomTextField(
                hintText: 'Purchase PlanedDate',
                controller: TextEditingController(text: purchaseDate),
                textInputType: TextInputType.text,
                readOnly: true,
                onTap: (){
                  _selectDate(context);
                },
              ),
              CustomTextField(
                hintText: 'Additional Information',
                controller: description,
                textInputType: TextInputType.text,
                       ),
              CustomButton(
                  onTap: () async{
                    if (_formKey.currentState!.validate()) {
                     var result = widget.poolPurchaseProvider.createPoolPurchase(
                          agentName:
                          '${model.userDetailList[0].firstName} ${model.userDetailList[0].lastName}',
                          city: selectedCity,
                          mobile: model.userDetailList[0].mobileNumber,
                          description: description.text,
                          email: model.userDetailList[0].emailId,
                          firstName: model.userDetailList[0].firstName,
                          id: model.userDetailList[0].id,
                          lastname: model.userDetailList[0].lastName,
                          lUserName: model.userDetailList[0].userName,
                          image: '',
                          purchaseItem: selectedPurchaseItem,
                          purchaseDate: purchaseDate+ " 00:00:00",
                          type: 'Pool Purchase').then((value) => {
                        showAnimatedDialog(
                            context,
                            MyDialog(
                              icon: Icons.check,
                              title:
                              'New Post',
                              description:
                              'Your post submitted successfully',
                              isFailed: false, isFromPost: false,
                            ),
                            dismissible: false,
                            isFlip: false),
                      });
                     if(result) {
                       Navigator.of(context).pop();
                     }
                    }},
                  buttonText: "Post")
            ],
          ),
        ),
      ),
    );
    /*return Scaffold(
      appBar: AppBar(
        title: Text('Post Pool Purchase',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: ColorResources.PRIMARY_COLOR,
      ),
      backgroundColor: ColorResources.HOME_BG,
      body: Form(
        key: _formKey,
        child: Consumer<AuthProvider>(
          builder: (context, model, child) => Container(
            margin: ResponsiveWidget.isDesktop(context)? EdgeInsets.symmetric(horizontal: 200,vertical: 10):ResponsiveWidget.isMobile(context)?EdgeInsets.symmetric(horizontal: 20,vertical: 10):EdgeInsets.symmetric(horizontal: 100,vertical: 10),
            child: ListView(
              shrinkWrap: true,
              children: [

                CustomDropdownList(
                  hintText: "Select Purchase Item",
                  items: itemList,
                  selectedType: selectedPurchaseItem,
                  onChange: (String value){
                    setState(() {
                      selectedPurchaseItem = value;
                    });
                  },
                ),
                CustomTextField(
                  hintText: 'Name',
                  controller: TextEditingController(
                      text: model.userDetailList[0].firstName ?? ''),
                  textInputType: TextInputType.text,
                  readOnly: true,
                ),
                CustomTextField(
                  hintText: 'Mobile',
                  controller: TextEditingController(
                      text:
                          model.userDetailList[0].mobileNumber.toString()),
                  textInputType: TextInputType.phone,
                  readOnly: true,
                ),
                CustomTextField(
                  hintText: 'Email',
                  controller: TextEditingController(
                      text: model.userDetailList[0].emailId ?? ''),
                  textInputType: TextInputType.emailAddress,
                  readOnly: true,
                ),
                CustomCityTextField(
                  hintText: 'Select City',
                  controller: selectedCity,
                  onTap: (){
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return CustomCityListDialog(
                              onTap : (String value){
                                setState(() {
                                  selectedCity = value;
                                });
                              }
                          );
                        }
                    ) ;
                  },
                ),
                CustomTextField(
                  hintText: 'Purchase PlanedDate',
                  controller: TextEditingController(text: purchaseDate),
                  textInputType: TextInputType.text,
                  readOnly: true,
                  onTap: (){
                    _selectDate(context);
                  },
                ),
                CustomTextField(
                  hintText: 'Additional Information',
                  controller: description,
                  textInputType: TextInputType.text,
                  isValidator: false,
                ),
                CustomButton(
                    onTap: () {
      if (_formKey.currentState!.validate()) {
                      widget.poolPurchaseProvider.createPoolPurchase(
                          agentName:
                              '${model.userDetailList[0].firstName} ${model.userDetailList[0].lastName}',
                          city: selectedCity,
                          mobile: model.userDetailList[0].mobileNumber,
                          description: description.text,
                          email: model.userDetailList[0].emailId,
                          firstName: model.userDetailList[0].firstName,
                          id: model.userDetailList[0].id,
                          lastname: model.userDetailList[0].lastName,
                          lUserName: model.userDetailList[0].userName,
                          image: '',
                          purchaseItem: selectedPurchaseItem,
                          purchaseDate: purchaseDate+ " 00:00:00",
                          type: 'Pool Purchase');
                      Navigator.of(context).pop();
                    }},
                    buttonText: "Post Jobs")
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
