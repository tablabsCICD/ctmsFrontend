import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addLeadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(
            "Add New Employee",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          )),
          SizedBox(height: 16),
          _buildTextField('Name', _nameController),
          SizedBox(height: 16),
          _buildTextField('Email', _emailController),
          SizedBox(height: 16),
          _buildTextField('Phone', _phoneController),
          /*Row(
            children: [
              Expanded(
                child: _buildTextField('Email', _emailController),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTextField('Phone', _phoneController),
              ),
            ],
          ),*/
          SizedBox(height: 16),
          _buildTextField('Add Employee', _addLeadController),
          SizedBox(height: 16),
          /*ElevatedButton(
            onPressed: _submitForm,
            child: Center(child: Text('Submit')),
          ),*/
          InkWell(
            onTap: _submitForm,
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String addLead = _addLeadController.text;

    // Here you can perform any logic with the data obtained from the form
    // For example, you can send this data to a server or save it locally.
  }
}