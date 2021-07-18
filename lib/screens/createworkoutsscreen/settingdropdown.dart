import 'package:flutter/material.dart';
import 'package:g60/screens/createworkoutsscreen/widgets/textdropdownfield.dart';

class SettingDropDown extends StatefulWidget {

  final String headerText;
  final List<dynamic> inputList;
  final dynamic initialValue;
  final Function onValueSelected;

  SettingDropDown({required this.headerText, required this.inputList, required this.initialValue, required this.onValueSelected});



  @override
  _SettingDropDownState createState() => _SettingDropDownState();
}

class _SettingDropDownState extends State<SettingDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            widget.headerText,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 5,),
          TextDropdownField(
            hintText: '',
            onUpdate: (newValue){
              widget.onValueSelected(newValue);
            },
            value: widget.initialValue,
            dropDownList: widget.inputList,
          ),
        ],
      ),
    );
  }
}
