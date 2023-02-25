import 'package:flutter/material.dart';

import '../../../config/locale/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../validation/text_field_validation.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextStyle? hintTextStyle;
  final int? maxLines;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final double borderWidth;
  final Color borderColor;
  final Color errorBorderColor;
  final Color? cursorColor;
  final bool secureText;
  final String validateType;
  final TextInputType keyboardType;
  final FormFieldSetter onSave;
  final TextAlign textAlign;
  final EdgeInsets contentPadding;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.hintTextStyle,
    required this.errorStyle,
    required this.errorBorderColor,
    required this.borderWidth,
    required this.borderColor,
    required this.secureText,
    required this.validateType,
    required this.keyboardType,
    required this.onSave,
    required this.textAlign,
    required this.contentPadding,
    required this.style,
    required this.cursorColor,
    required this.maxLines,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  String validation = "";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ,
      keyboardType: widget.keyboardType,
      obscureText: widget.secureText,
      obscuringCharacter: "*",
      autocorrect: false,
      textAlign: widget.textAlign,
      enableSuggestions: false,
      style: widget.style,
      onSaved: widget.onSave,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle,
        floatingLabelStyle: TextStyle(color: AppColors.fontPrimary),
        contentPadding: widget.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: widget.errorBorderColor,
            width: widget.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: widget.errorBorderColor,
            width: widget.borderWidth,
          ),
        ),
        errorStyle: widget.errorStyle,
      ),
      onChanged: (value) {
        validation = ValidateTextFiled.validate(value, widget.validateType)!;
      },
      validator: (value) {
        return validation == ""
            ? null
            : AppLocalizations.of(context)!.translate(validation)!;
      },
    );
  }
}
