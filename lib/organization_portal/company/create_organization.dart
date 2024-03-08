import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization_portal/constant.dart';
import 'package:flutter_hr_management/organization_portal/dialog/CustomCityListDialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/CustomStateListDialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_dropdown_list.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/cutom_city_textfield.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

class CreateOrganization extends StatefulWidget {
  @override
  _CreateOrganizationState createState() => _CreateOrganizationState();
}

class _CreateOrganizationState extends State<CreateOrganization> {
  List<Organization> foundOrganization = [];

  final orgProvider = locator<OrgProvider>();
  final authProvider = locator<AuthProvider>();

  @override
  initState() {
    orgProvider.getOrganizationList();
    foundOrganization = orgProvider.orgVerifiedList;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Organization> results = [];
    if (enteredKeyword.isEmpty) {
      results = orgProvider.orgVerifiedList;
    } else {
      results = orgProvider.orgVerifiedList
          .where((user) => user.companyName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundOrganization = results;
    });
  }

  TextEditingController organizationController = TextEditingController();
  TextEditingController gst1Controller = new TextEditingController();
  TextEditingController gst2Controller = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController landlineController = new TextEditingController();
  TextEditingController websiteController = new TextEditingController();

  TextEditingController panController = new TextEditingController();
  TextEditingController tanController = new TextEditingController();
  TextEditingController pointController = new TextEditingController();
  TextEditingController offEmailController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  String? selectedCity = "Pune", selectedState = 'Maharastra';
  var selectedPostType = 'Private Limited Company';
  int selectecdIndex = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) => Container(
        color: ColorResources.HOME_BG,
        padding: ResponsiveWidget.isDesktop(context) ? EdgeInsets.symmetric(horizontal: 150.0, vertical: 16):EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
        //padding: EdgeInsets.all(16),
        child: ListView(
          /* crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,*/
          children: [
            TextField(
              controller: organizationController,
              style: Style.dropdownValue,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  hintStyle: Style.searchHint,
                  hintText: 'Select Company Name',
                  suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            foundOrganization.isNotEmpty
                ? Container(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        itemCount: foundOrganization.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  organizationController.text =
                                      foundOrganization[index]
                                          .companyName
                                          .toString();
                                  selectecdIndex = index;
                                });
                              },
                              title: CustomText(
                                foundOrganization[index].companyName.toString(),
                                style: Style.title,
                              ),
                            ),
                          );
                        }),
                  )
                : CustomText(
                    'Organization not found, Please create new organization',
                    style: Style.title,
                  ),
            SizedBox(height: 16,),
            organizationController.text.isEmpty || foundOrganization.isEmpty
                ? CustomButton(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Constants.padding),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.only(
                                    left: Constants.padding,
                                    top: Constants.padding,
                                    right: Constants.padding,
                                    bottom: Constants.padding):EdgeInsets.all(0),
                                margin: ResponsiveWidget.isDesktop(context)?EdgeInsets.only(
                                  top: Constants.avatarRadius,
                                  left: 250,
                                  right: 250,
                                  bottom: Constants.avatarRadius,
                                ):EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(Constants.padding),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                                    ]),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,size: 18,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Center(
                                                child: CustomText('Create New Organization',
                                                    style: Style.heading)),
                                            CustomCityTextField(
                                              hintText: 'Select City',
                                              controller: selectedCity!,
                                              onTap: () {
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
                                              hintText: 'Company Name',
                                              controller: companyController,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomTextField(
                                              hintText: 'Enter Official Email_id',
                                              controller: offEmailController,
                                              textInputType: TextInputType.emailAddress,
                                              isEmail: true,
                                            ),
                                            CustomTextField(
                                              hintText: 'Enter Company Mobile Number',
                                              controller: mobileController,
                                              textInputType: TextInputType.number,
                                              isPhoneNumber: true,
                                              isValidator: true,
                                            ),
                                            CustomTextField(
                                              hintText: 'Enter Landlines Number',
                                              controller: landlineController,
                                              textInputType: TextInputType.number,
                                            ),
                                            CustomTextField(
                                              hintText: 'Company Address',
                                              controller: addressController,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomTextField(
                                              hintText: 'Company Website',
                                              controller: websiteController,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomTextField(
                                              hintText: 'Enter GST Number1',
                                              controller: gst1Controller,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomTextField(
                                              hintText: 'Click to upload Aadhar Card',
                                              controller: gst2Controller,
                                              textInputType: TextInputType.text,
                                              readOnly: true,
                                              onTap: () async {
                                                var doc = await pickFile(model).then((value){
                                                  print("In pickfile response");
                                                  print(value);
                                                });
                                              },
                                            ),
                                            CustomTextField(
                                              hintText: 'Pan Card Number',
                                              controller: panController,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomTextField(
                                              hintText: 'Enter Tan Number',
                                              controller: tanController,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomCityTextField(
                                              hintText: 'Select State',
                                              controller: selectedState!,
                                              onTap: () {
                                                showDialog(context: context,
                                                    builder: (BuildContext context){
                                                      return CustomStateListDialog(
                                                          onTap : (String value){
                                                            setState(() {
                                                              selectedState = value;
                                                            });
                                                          }
                                                      );
                                                    }
                                                ) ;
                                              },
                                            ),
                                            CustomTextField(
                                              hintText: 'Point Of Name',
                                              controller: pointController,
                                              textInputType: TextInputType.text,
                                            ),
                                            CustomDropdownList(
                                              hintText: 'Type of Registration',
                                              items: [
                                                'Private Limited Company',
                                                'Public Limited Company',
                                                'Partnerships',
                                                'Limited Liability Partnership',
                                                'One Person Company',
                                                'Sole Proprietorship'
                                              ],
                                              selectedType: selectedPostType,
                                              onChange: (String value){
                                                setState(() {
                                                  selectedPostType = value;
                                                });
                                              },
                                            ),

                                            CustomButton(
                                                onTap: () {
                            if (_formKey.currentState!.validate()) {
                                                  model
                                                      .createOrg(
                                                      panCard: panController.text,
                                                      tanCard: tanController.text,
                                                      city: selectedCity,
                                                      companyName: companyController.text,
                                                      companyAddress: addressController.text,
                                                      cMobile: mobileController.text,
                                                      gst: gst1Controller.text,
                                                      gst1: gst2Controller.text,
                                                      typeOfRegistration: selectedPostType,
                                                      landlineNumber: landlineController.text,
                                                      numberOfTimesRating: 1,
                                                      rating: 5,
                                                      verified: 0,
                                                      state: selectedState,
                                                      offEmail: offEmailController.text,
                                                      pointName: pointController.text,
                                                      website: websiteController.text)
                                                      .then((value) => {
                                                    showAnimatedDialog(
                                                        context,
                                                        MyDialog(
                                                          icon: Icons.check,
                                                          title: 'New Organization',
                                                          description:
                                                          'Organization Created successfully',
                                                          isFailed: false, isFromPost: false,
                                                        ),
                                                        dismissible: false,
                                                        isFlip: false),
                                                  });
                                                  Navigator.of(context).pop();
                                                }},
                                                buttonText: 'Create Organization'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    buttonText: 'Create Organization')
                : CustomButton(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => new CupertinoAlertDialog(
                                title: CustomText(
                                    'Are you sure want to link this organization?',
                                    style: Style.heading),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(getTranslated('yes', context)!,
                                        style: Style.okButton),
                                    onPressed: () {
                                      authProvider
                                          .updateUser(
                                            companyId: model
                                                .orgVerifiedList[selectecdIndex].id,
                                            companyName: model
                                                .orgVerifiedList[selectecdIndex]
                                                .companyName,
                                            companyAddress: model
                                                .orgVerifiedList[selectecdIndex]
                                                .companyAddress,
                                          )
                                          .then((value) => {
                                                showAnimatedDialog(
                                                    context,
                                                    MyDialog(
                                                      icon: Icons.check,
                                                      title:
                                                          'Link Organization',
                                                      description:
                                                          'Your organization link successfully',
                                                      isFailed: false, isFromPost: false,

                                                    ),
                                                    dismissible: false,
                                                    isFlip: false)
                                              });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child:
                                        Text('no', style: Style.cancelButton),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                    },
                    buttonText: 'Link Organization')
          ],
        ),
      ),
    );
  }

  getWidget() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:  Consumer<OrgProvider>(
        builder: (context, model, child) => Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(
            top: Constants.avatarRadius,
            left: 250,
            right: 250,
            bottom: Constants.avatarRadius,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                        child: CustomText('Create New Organization',
                            style: Style.heading)),
                    CustomCityTextField(
                      hintText: 'Select City',
                      controller: selectedCity!,
                      onTap: () {
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
                      hintText: 'Company Name',
                      controller: companyController,
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      hintText: 'Enter Official Email_id',
                      controller: offEmailController,
                      textInputType: TextInputType.emailAddress,
                      isEmail: true,
                    ),
                    CustomTextField(
                      hintText: 'Enter Company Mobile Number',
                      controller: mobileController,
                      textInputType: TextInputType.number,
                      isPhoneNumber: true,
                    ),
                    CustomTextField(
                      hintText: 'Enter Landlines Number',
                      controller: landlineController,
                      textInputType: TextInputType.number,
                      isValidator: false,
                    ),
                    CustomTextField(
                      hintText: 'Company Address',
                      controller: addressController,
                      textInputType: TextInputType.text,
                      isValidator: false,
                    ),
                    CustomTextField(
                      hintText: 'Company Website',
                      controller: websiteController,
                      textInputType: TextInputType.text,
                      isValidator: false,
                    ),
                    CustomTextField(
                      hintText: 'Enter GST Number1',
                      controller: gst1Controller,
                      textInputType: TextInputType.text,
                    ),
                    CustomTextField(
                      hintText: 'Click to upload Aadhar Card',
                      controller: gst2Controller,
                      textInputType: TextInputType.text,
                      readOnly: true,
                      onTap: () async {
                        var doc = await pickFile(model).then((value){
                          print("In pickfile response");
                          print(value);
                        });
                      },
                    ),
                    CustomTextField(
                      hintText: 'Pan Card Number',
                      controller: panController,
                      textInputType: TextInputType.text,
                    ),
                    CustomTextField(
                      hintText: 'Enter Tan Number',
                      controller: tanController,
                      textInputType: TextInputType.text,
                      isValidator: false,
                    ),
                    CustomCityTextField(
                      hintText: 'Select State',
                      controller: selectedState!,
                      onTap: () {
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return CustomStateListDialog(
                                  onTap : (String value){
                                    setState(() {
                                      selectedState = value;
                                    });
                                  }
                              );
                            }
                        ) ;
                      },
                    ),
                    CustomTextField(
                      hintText: 'Point Of Name',
                      controller: pointController,
                      textInputType: TextInputType.text,
                    ),
                    CustomDropdownList(
                      hintText: 'Type of Registration',
                      items: [
                        'Private Limited Company',
                        'Public Limited Company',
                        'Partnerships',
                        'Limited Liability Partnership',
                        'One Person Company',
                        'Sole Proprietorship'
                      ],
                      selectedType: selectedPostType,
                      onChange: (String value){
                        setState(() {
                          selectedPostType = value;
                        });
                      },
                    ),

                    CustomButton(
                        onTap: () {
                          model
                              .createOrg(
                                  panCard: panController.text,
                                  tanCard: tanController.text,
                                  city: selectedCity,
                                  companyName: companyController.text,
                                  companyAddress: addressController.text,
                                  cMobile: mobileController.text,
                                  gst: gst1Controller.text,
                                  gst1: gst2Controller.text,
                                  typeOfRegistration: selectedPostType,
                                  landlineNumber: landlineController.text,
                                  numberOfTimesRating: 1,
                                  rating: 5,
                                  verified: 0,
                                  state: selectedState,
                                  offEmail: offEmailController.text,
                                  pointName: pointController.text,
                                  website: websiteController.text)
                              .then((value) => {
                                    showAnimatedDialog(
                                        context,
                                        MyDialog(
                                          icon: Icons.check,
                                          title: 'New Organization',
                                          description:
                                              'Organization Created successfully',
                                          isFailed: false,
                                          isFromPost: false,
                                        ),
                                        dismissible: false,
                                        isFlip: false),
                                  });
                          Navigator.of(context).pop();
                        },
                        buttonText: 'Create Organization'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PlatformFile? objFile;
  File? imagefile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(OrgProvider model) async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        // imagefile = File(result.files.first.name);
        imageBytes = result.files.first.bytes;
        print(fileName);
        gst2Controller.text = fileName!;
        model.setImage(fileName);
        var docs =  await model.uploadCompanyDocuments(imageFilePath: fileName,imageBytes: imageBytes,objectFile: objFile);
        print(docs);
        return docs;
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }

}
