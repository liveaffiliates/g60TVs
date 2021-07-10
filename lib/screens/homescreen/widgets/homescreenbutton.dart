
import 'package:flutter/material.dart';

class HomeScreenButton extends StatelessWidget {

  final String text;
  final VoidCallback onButtonPressed;

  HomeScreenButton({required this.text, required this.onButtonPressed});


  @override
  Widget build(BuildContext context) {
    return
      ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1000),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => onButtonPressed(),
              child: Text(text, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
                  minimumSize: MaterialStateProperty.all(Size(60, 60)),
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50)),)),
            ),
          ),
        ],
      ),
    );
  }
}
