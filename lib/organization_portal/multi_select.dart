import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/more_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

import 'model/truck_load_model.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key? key, this.items, this.initialSelectedValues,this.obj}) : super(key: key);

  final List<MultiSelectDialogItem<V>>? items;
  final Set<V>? initialSelectedValues;
  TruckLoad? obj;
  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues!);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
    }});
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {

     Navigator.pop(context, _selectedValues);
  }

  String feedBackDetails = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText("Feedback",style: Style.heading,),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
          child: ListTileTheme(
            contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
            child: ListBody(
              children: widget.items!.map(_buildItem).toList(),
            ),
          ),

      ),
      actions: <Widget>[
        Consumer<MoreProvider>(
          builder: (context, model, child) => ElevatedButton(
            child: CustomText(
              "Ok",
            ),
            onPressed: () {
            _selectedValues.forEach((element) {
              if(element==1){
                feedBackDetails = 'I RECEIVED VERY GOOD RESPONSE BY CALLS.';
              } else if(element==2){
                feedBackDetails = feedBackDetails + 'I RECEIVED MANY BIDS.';
              } else if(element==3){
                feedBackDetails = feedBackDetails + 'THANKS MY WORK WAS DONE.';
              } else if(element==4){
                feedBackDetails = feedBackDetails + 'WE SAVED ON TRANSPORTATION.';
              } else{
                feedBackDetails = feedBackDetails + 'WE DID NOT GET ANY RESPONSE.';
              }
            });

              model.saveFeedback(
                  id: 0,
                  feedbackDetails: feedBackDetails,
                  postId: widget.obj!.id,
                  rating: int.parse(widget.obj!.ratings.toString()),
                  userId: widget.obj!.userId,type: widget.obj!.type
              ).then((value) => {
                showAnimatedDialog(
                    context,
                    MyDialog(
                      icon: Icons
                          .check,
                      title:
                      'Feedback',
                      description:
                      'Your feedback submitted successfully',
                      isFailed:
                      false, isFromPost: false,
                    ),
                    dismissible:
                    false,
                    isFlip: false)
              });
              Navigator.pop(context, _selectedValues);
            },
          ),
        ),
        ElevatedButton(
          child: CustomText(
            "Cancel",
          ),
          onPressed: () {
            _onCancelTap();
          },
        ),
       /* CustomButton(
          buttonText: getTranslated('cancel', context),
          onTap: _onCancelTap,
        ),
        Consumer<DashboardProvider>(
          builder: (context, model, child) => CustomButton(
            buttonText: "Ok",
            onTap: (){
              model.flr = false;
              model.fla = false;
              model.plr = false;
              model.pla = false;
              _selectedValues.forEach((element) {
                if(element == 2){
                  model.flr = true;
                }
                if(element == 3){
                  model.plr = true;
                }
                if(element == 4){
                  model.fla = true;
                }
                if(element == 5){
                  model.pla = true;
                }
              });

              model.getFullLoadTruckList();
              Navigator.pop(context, _selectedValues);
            }
          ),
        )*/
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label,style: Style.filtterContent,),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked!),
    );
  }
}