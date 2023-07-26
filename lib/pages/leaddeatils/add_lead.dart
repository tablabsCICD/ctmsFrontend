import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class AddLead extends StatefulWidget {
  const AddLead({Key key}) : super(key: key);

  @override
  State<AddLead> createState() => _AddLeadState();
}

class _AddLeadState extends State<AddLead> {
  // Variables to store the form field values
  String leadName = '';
  String leadEmail = '';
  String phoneNumber = '';
  String description = '';
  String acquireFrom = '';

  // List of options for the 'Acquire From' dropdown
  List<String> acquireFromOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];
  List<String> additionalDropdownOptions = [
    'Digvijay',
    'Kishor',
  ];

  // Selected option for the additional dropdown
  String selectedAdditionalDropdownOption = '';


  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
        color: AppColor.white, borderRadius: BorderRadius.circular(10)),
    padding: EdgeInsets.all(10),
      child: addLeadForm(),);
  }


  Widget addLeadForm() {
    // String? _selectedAssignee;
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child:
      Column(
        children: [
          Center(child: Text(
            "Add New Lead",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          )),
          // Lead name field
          textFieldWithBorder(
            labelText: 'Lead Name',
            onChanged: (value) {
              setState(() {
                leadName = value;
              });
            },
          ),
          SizedBox(height: 15),
          textFieldWithBorder(
            labelText: 'Lead Email',
            onChanged: (value) {
              setState(() {
                leadEmail = value;
              });
            },
          ),
          SizedBox(height: 15),
          textFieldWithBorder(
            labelText: 'Phone Number',
            onChanged: (value) {
              setState(() {
                phoneNumber = value;
              });
            },
          ),
          SizedBox(height: 15),
          // Description field
          textFieldWithBorder(
            labelText: 'Description',
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          SizedBox(height: 15),
          // Acquire From dropdown field
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Acquire From',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.black),),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedAdditionalDropdownOption.isNotEmpty
                    ? selectedAdditionalDropdownOption
                    : null,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    selectedAdditionalDropdownOption = newValue;
                  });
                },
                items: additionalDropdownOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),
            ),

          ),
          SizedBox(height: 15),
          InkWell(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.yellow,
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColor.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldWithBorder({
    String labelText,
    ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,


      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Enter $labelText',
        labelStyle:TextStyle(
          color: Colors.grey,
      ),

    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0, color: Colors.black),),



        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
    );
  }
}
