import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:g60/theme/g60_colors.dart';

class TextEntryField extends StatelessWidget {

  final TextInputType inputType;
  final String hintText;
  final int numberOfLines;
  final Function onChanged;
  final String initialValue;
  final bool enable;

  TextEntryField({
    required this.inputType,
    required this.hintText,
    required this.numberOfLines,
    required this.initialValue,
    required this.onChanged,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
              enabled: enable,
              initialValue: initialValue,
              keyboardType: inputType,
              autofocus: false,
              textAlign: TextAlign.center,
              maxLines: numberOfLines,
              decoration: InputDecoration(
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
              onChanged: (value) => onChanged(value)
            ),
          ),
        ],
      ),
    );
  }
}