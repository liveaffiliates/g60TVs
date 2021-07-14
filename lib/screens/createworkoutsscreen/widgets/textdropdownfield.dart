import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g60/theme/g60_colors.dart';

class TextDropdownField extends StatelessWidget {

  final String hintText;
  final Function onUpdate;
  final String value;
  final List <String> dropDownList;

  TextDropdownField({
    required this.hintText,
    required this.dropDownList,
    required this.value,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InputDecorator(
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.1),
                hintText: hintText,
                hintStyle: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.normal),

              ),
              child: Listener(
                onPointerDown:(_) { FocusScope.of(context).requestFocus(FocusNode());},
                child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: value,
                  isDense: true,
                  onChanged: (String? newValue) => onUpdate(newValue),
                  items: dropDownList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text(value)),
                    );
                  }).toList(),
                hint: Text(
                  hintText,
                  style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.start,
                ),
                ),
          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}