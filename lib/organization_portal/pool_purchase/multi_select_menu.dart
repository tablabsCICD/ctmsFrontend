import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';

class MultiSelectMenu<V> {
  const MultiSelectMenu(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectMenuDialog<V> extends StatefulWidget {
  MultiSelectMenuDialog({Key? key, this.items, this.initialSelectedValues}) : super(key: key);

  final List<MultiSelectMenu<V>>? items;
  final Set<V>? initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectMenuDialogState<V>();
}

class _MultiSelectMenuDialogState<V> extends State<MultiSelectMenuDialog<V>> {
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
        if(itemValue == 1)
          _selectedValues.addAll(widget.initialSelectedValues!);
        else
          _selectedValues.remove(1);
      } else {
        _selectedValues.remove(itemValue);
        if(itemValue == 1) {
          _selectedValues.removeAll(widget.initialSelectedValues!);
          locator<PoolPurchaseProvider>().vehicles = false;
          locator<PoolPurchaseProvider>().tyres = false;
          locator<PoolPurchaseProvider>().body_building = false;
          locator<PoolPurchaseProvider>().finance = false;
          locator<PoolPurchaseProvider>().insurance = false;
          locator<PoolPurchaseProvider>().other = false;

        }
        else
          _selectedValues.remove(1);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    _selectedValues.forEach((element) {
      if(element == 2){
        locator<PoolPurchaseProvider>().vehicles = true;
      }
      if(element == 3){
        locator<PoolPurchaseProvider>().tyres = true;
      }
      if(element == 4){
        locator<PoolPurchaseProvider>().body_building = true;
      }
      if(element == 5){
        locator<PoolPurchaseProvider>().finance = true;
      }
      if(element == 6){
        locator<PoolPurchaseProvider>().insurance = true;
      }
      if(element == 7){
        locator<PoolPurchaseProvider>().other = true;
      }
    });
    locator<PoolPurchaseProvider>().getFilteredData();
    Navigator.pop(context, _selectedValues);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getTranslated('type_of_requirement', context)!,style: Style.heading,),
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
        CustomButton(
          buttonText: getTranslated('cancel', context),
          onTap: _onCancelTap,
        ),
        Consumer<PoolPurchaseProvider>(
          builder: (context, model, child) => CustomButton(
            buttonText: getTranslated('apply', context),
            onTap: //_onSubmitTap,
            (){
              model.vehicles = false;
              model.insurance = false;
              model.finance = false;
              model.body_building = false;
              model.other = false;
              model.tyres = false;
              _selectedValues.forEach((element) {
                if(element == 2){
                  model.vehicles = true;
                }
                if(element == 3){
                  model.tyres = true;
                }
                if(element == 4){
                  model.body_building = true;
                }
                if(element == 5){
                  model.finance = true;
                }
                if(element == 6){
                  model.insurance = true;
                }
                if(element == 7){
                  model.other = true;
                }
              });
              model.getFilteredData();
              Navigator.pop(context, _selectedValues);
            }
          ),
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectMenu<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label,style: Style.filtterContent,),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked!),
    );
  }
}