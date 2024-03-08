 import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function onClearPressed;
  final Function onSubmit;
  SearchWidget({required this.controller,required this.hintText, required this.onClearPressed, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
   // final TextEditingController _controller = TextEditingController();
    return Container(
      height: 35,
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      child:Container(
        decoration: BoxDecoration(
          color: ColorResources.SEARCH_BAR_COLOR,
          borderRadius: BorderRadius.circular(5),
         /* boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0,
            ),],*/

        ),
          child: TextFormField(
            controller: controller,

            onFieldSubmitted: (query) {
              onSubmit(query);
            },
            onChanged: (query) {

            },
            textInputAction: TextInputAction.search,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              isDense: true,
              hintStyle: Style.searchHint,
              border: InputBorder.none,
              prefixIcon: Image.asset('assets/images/loupe.png',height: 17,width: 17,),
              suffixIcon: controller.text.isNotEmpty ? IconButton(
                icon: Icon(Icons.clear, color: ColorResources.PRIMARY_COLOR),
                onPressed: () {
                  onClearPressed();
                  controller.clear();
                },
              ) : controller.text.isNotEmpty ? IconButton(
                icon: Icon(Icons.clear, color: ColorResources.PRIMARY_COLOR),
                onPressed: () {
                  onClearPressed();
                  controller.clear();
                },
              ) : null,
            ),
          ),
        ),

      );
  }
}
