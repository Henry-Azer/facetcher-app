import 'package:facetcher/core/widgets/buttons/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/validation/validation_types.dart';
import '../../../../core/widgets/forms/text_field_widget.dart';
import '../../domain/entities/message_us_request.dart';

class MessageUsForm extends StatefulWidget {
  const MessageUsForm({Key? key}) : super(key: key);

  @override
  State<MessageUsForm> createState() => _MessageUsFormState();
}

class _MessageUsFormState extends State<MessageUsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late MessageUsRequest messageUsRequest = MessageUsRequest(
      title: messageUsRequest.title, message: messageUsRequest.message);
  final bool _isFormEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            TextFieldWidget(
              enabled: _isFormEnabled,
              hintText: 'Title',
              hintTextStyle: AppTextStyle.drawingDetailsField,
              keyboardType: TextInputType.emailAddress,
              validateType: ValidationTypes.drawingDetailsTitle,
              errorStyle: AppTextStyle.loginFieldErrorText,
              errorBorderColor: AppColors.error,
              borderColor: AppColors.border,
              borderWidth: 1,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: AppTextStyle.loginFieldText,
              cursorColor: AppColors.textSecondary,
              secureText: false,
              onSave: (value) {
                messageUsRequest.title = value;
              },
              contentPadding: const EdgeInsets.only(
                top: 12,
                left: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextFieldWidget(
                enabled: _isFormEnabled,
                hintText: 'Description',
                hintTextStyle: AppTextStyle.drawingDetailsField,
                keyboardType: TextInputType.emailAddress,
                validateType: ValidationTypes.drawingDetailsDescription,
                errorStyle: AppTextStyle.loginFieldErrorText,
                errorBorderColor: AppColors.error,
                borderColor: AppColors.border,
                borderWidth: 1,
                maxLines: 10,
                textAlign: TextAlign.start,
                style: AppTextStyle.loginFieldText,
                cursorColor: AppColors.textSecondary,
                secureText: false,
                onSave: (value) {
                  messageUsRequest.message = value;
                },
                contentPadding: const EdgeInsets.only(
                  top: 40,
                  left: 30,
                ),
              ),
            ),
            ButtonWidget(
              backgroundColor: AppColors.button,
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  if (messageUsRequest.title.isEmpty) {
                    Constants.showSnackBar(
                        context: context, message: "Title can't be blank");
                    return;
                  }
                  if (messageUsRequest.message.isEmpty) {
                    Constants.showSnackBar(
                        context: context,
                        message: "Description can't be blank");
                    return;
                  }
                }
              },
              child: Text("Send"),
            )
          ],
        ),
      ),
    );
  }
}
