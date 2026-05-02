import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/light_theme.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? hintText, label, errorText;
  final TextInputType type;
  final bool password;
  final DateTime? startdate;
  final DateTime? enddate;
  final List<TextInputFormatter>? inputFormatters;
  final bool expanded;
  final Color activeBorderColor, borderColor, hintColor;
  final bool floatingHint;
  final int? maxLines;
  final int? minLines;
  final String? helperText;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Function(DateTime date)? onDateSelected;
  FocusNode? focusNode;
  TextAlign textalign;
  int? maxLengh;
  TextDirection? textdirection;
  EdgeInsetsDirectional? contentPadding;
  double borderRadius;
  double? hintSize;
  String? prefixIcon;
  Widget? suffixIcon, suffixWidget, prefixWidget;
  TextEditingController? controller;
  InputDecoration? inputDecoration;
  ValueChanged<String>? onChanged;
  ValueChanged<String?>? onSaved;
  ValueChanged<String?>? onFieldSubmitted;
  String? Function(String?)? validator;
  bool? isOutline;
  bool? enable;
  bool? readOnly;
  final bool enableMapPicker;
  final bool enableFilePicker;
  final bool enableDatePicker;
  final bool enableImagePicker;

  final Function(File image)? onImageSelected;
  final Function()? onImageDeleted;

  TextFormFieldWidget({
    this.onChanged,
    this.onSaved,
    this.onDateSelected,
    this.isOutline,
    this.readOnly,
    this.onFieldSubmitted,
    this.hintSize,
    this.enable,
    this.validator,
    this.onTap,
    this.prefixWidget,
    this.password = false,
    this.expanded = false,
    this.floatingHint = false,
    this.type = TextInputType.text,
    this.hintText = "",
    this.label,
    this.textalign = TextAlign.start,
    this.maxLengh,
    this.errorText,
    this.controller,
    this.activeBorderColor = Colors.blue,
    this.borderRadius = 12.0,
    this.borderColor = Colors.black,
    this.backgroundColor,
    this.hintColor = LightThemeColors.textHint,
    this.maxLines,
    this.minLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.inputDecoration,
    this.contentPadding,
    this.textdirection,
    this.onImageSelected,
    this.onImageDeleted,
    super.key,
    this.inputFormatters,
    this.helperText,
    this.startdate,
    this.enddate,
  }) : enableMapPicker = false,
       enableFilePicker = false,
       enableDatePicker = false,
       enableImagePicker = false;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool passHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          SizedBox(height: 12),
        ],
        TextFormField(
          onTap: () {
            widget.onTap?.call();
          },
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          cursorColor: Colors.black,
          readOnly:
              (widget.readOnly ?? false) ||
              widget.enableMapPicker ||
              widget.enableImagePicker,
          enabled: widget.enable ?? true,

          /// VALIDATOR
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          maxLength: widget.maxLengh,
          focusNode: widget.focusNode,
          controller: widget.controller,

          maxLines: widget.maxLines ?? 1,
          minLines: widget.minLines,
          textAlign: widget.textalign,
          textDirection: widget.textdirection,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          decoration:
              widget.inputDecoration ??
              InputDecoration(
                contentPadding:
                    widget.contentPadding ??
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                filled: true,
                fillColor: widget.backgroundColor ?? Colors.white,
                prefixIcon: widget.prefixIcon == null
                    ? null
                    : SvgPicture.asset(widget.prefixIcon ?? ""),
                prefix: widget.prefixWidget,
                suffix: widget.suffixWidget,
                suffixIcon:
                    widget.suffixIcon ??
                    (widget.password
                        ? IconButton(
                            onPressed: () =>
                                setState(() => passHidden = !passHidden),
                            icon: Icon(
                              passHidden
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off,
                              color: LightThemeColors.primary.withOpacity(.5),
                            ),
                          )
                        : null),
                errorText: widget.errorText,
                helperText: widget.helperText,
                border: borderType(),
                focusedBorder: borderType(),
                enabledBorder: borderType(),
                errorBorder: borderType(),
                hintStyle: TextStyle(
                  color: widget.hintColor,
                  fontSize: widget.hintSize ?? 14,
                  fontWeight: FontWeight.w400,
                ),
                hintText: widget.hintText,
              ),
          keyboardType: widget.type,
          obscureText: passHidden && widget.password,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }

  InputBorder borderType() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: widget.activeBorderColor, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
    );
  }
}
