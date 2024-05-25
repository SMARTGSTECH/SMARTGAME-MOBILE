import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartbet/utils/config/color.dart';

///import 'package:kingcards_app/core/helpers/helpers.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    this.maxLength,
    this.autofocus = false,
    this.readOnly = false,
    this.onChanged,
    this.initialValue,
    this.label,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.helperText,
    this.height,
    this.hintColor,
    this.borderWidth,
    this.onTap,
    this.onSaved,
    this.width,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    //  this.autovalidate = AutovalidateMode.disabled,
    this.maxLines = 1,
    this.inputFormatters,
    this.errorText,
    Key? key,
    this.spacerHeight,
    this.topPadding,
    this.enableInteractiveSelection = true,
    this.labelTextStyle,
    this.enable = true,
    this.onTapDown,
    this.borderRadius,
    this.isRequired,
    this.fillColor,
    this.cursorColor,
    this.inputColor,
    this.labelText,
    this.boxHeight,
    this.allowWordSpacing = false,
  }) : super(key: key);

  final Color? fillColor;
  final Color? cursorColor;
  final Color? inputColor;
  final bool enable;
  final bool? isRequired;
  final Function? onTapDown;
  final TextStyle? labelTextStyle;
  final bool enableInteractiveSelection;
  final double? topPadding;
  final double? spacerHeight;
  final int? maxLength;
  final int maxLines;
  final double? width;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? helperText;
  final String? labelText;
  final Color? hintColor;
  final TextEditingController? controller;
  final double? borderWidth;
  final double? height;
  final String? Function(String?)? validator;
  final Function? onSaved;
  final Function? onTap;
  final double? boxHeight;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? label;
  final String? initialValue;
  final Function? onChanged;
  final bool readOnly;
  final bool autofocus;
  final double? borderRadius;
  // final AutovalidateMode autovalidate;
  final List<TextInputFormatter>? inputFormatters;
  final bool allowWordSpacing;

  @override
  Widget build(BuildContext context) {
    Widget textFormField = SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: boxHeight,
      child: TextFormField(
        enableInteractiveSelection: enableInteractiveSelection,
        readOnly: readOnly,
        enabled: enable,
        //  autovalidateMode: autovalidate,
        //autovalidate: autovalidate,
        onChanged: onChanged as void Function(String)?,
        maxLength: maxLength,
        initialValue: initialValue,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted as void Function(String)?,
        autofocus: autofocus,
        maxLines: maxLines,
        inputFormatters: allowWordSpacing
            ? inputFormatters
            : [
                FilteringTextInputFormatter.deny(RegExp('[ ]')),
              ],
        //style: kInputTextStyle(context),
        validator: validator,
        onSaved: onSaved as void Function(String?)?,
        onTap: onTap as void Function()?,
        cursorColor: cursorColor ?? const Color(0xFF4F4F4F),
        style: TextStyle(
          //  fontFamily: AppFont.euclidCircularARegular,
          fontSize: 14.sp,
          color: inputColor ?? const Color(0xFF4F4F4F),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? const Color(0xfff8f8f8),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xFF4F4F4F),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: ColorConfig.lightBoarder),
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
          hintText: hintText,
          helperMaxLines: 2,
          errorMaxLines: 2,
          errorText: errorText,
          hintStyle: TextStyle(
              color: hintColor ?? const Color(0xFF9FA4BC),

              ///  fontFamily: AppFont.euclidCircularARegular,
              fontSize: 14.sp),
          helperText: helperText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );

    return label == null
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: textFormField,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: topPadding ?? 0,
              ),
              Row(
                children: [
                  Text(
                    label!,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFB5C0D7)),
                    // style: labelTextStyle ?? kLabelTextStyle
                  ),
                  Text(
                    isRequired == null || isRequired == false ? '' : '*',
                    style: const TextStyle(
                        fontFamily: 'Nunito', fontSize: 16, color: Colors.red),
                    // style: labelTextStyle ?? kLabelTextStyle
                  ),
                ],
              ),
              SizedBox(
                height: spacerHeight ?? 10.0.h,
              ),
              textFormField
            ],
          );
  }

  widget() {
    return TextFormField(
      style: TextStyle(
        color: const Color(0xFF224188),
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color: const Color(0xFF4F4F4F),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.red),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    required this.textEditingController,
    this.onEditingComplete,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.maxLines,
    this.inputFormatters,
    this.maxLength,
    this.suffixIcon,
    this.textInputAction,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController textEditingController;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? labelText;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      ///   obscureText: true,
      controller: textEditingController,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete ??
          () {
            textEditingController.text.trim();
          },
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF0F3F6),
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xff9FA4BC),
          fontSize: 14.sp,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: const Color(0xff9FA4BC),
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
