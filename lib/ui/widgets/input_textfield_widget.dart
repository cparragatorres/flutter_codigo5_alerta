import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFieldWidget extends StatelessWidget {
  String hintText;
  int? maxLength;
  TextInputType? textInputType;
  TextEditingController controller;

  InputTextFieldWidget({
    required this.hintText,
    this.maxLength,
    this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        maxLength: maxLength,
        inputFormatters: maxLength != null
            ? [
                FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
              ]
            : [],
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty) return "El campo es obligatorio";

          if (maxLength != null) {
            if (value.length < maxLength!)
              return "El DNI debe de tener 8 dígitos";
          }
          return null;
        },
      ),
    );
  }
}
