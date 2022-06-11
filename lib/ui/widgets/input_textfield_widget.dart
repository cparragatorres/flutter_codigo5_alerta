
import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {

  String hintText;
  InputTextFieldWidget({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextField(
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        maxLength: 8,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff262A34),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: 14.0,
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
