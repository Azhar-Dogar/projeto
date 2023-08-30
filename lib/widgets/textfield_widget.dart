import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    required this.controller,
    this.hint,
    this.textInputType,
    this.suffix,
    this.onChanged,
    this.maxLines = 1,
    this.secureText,
    this.borderColor,
    this.showBorder = false,
    this.prefixWidget,
    this.fontSize,
    this.backColor,
    this.label,
    this.labelColor,
    this.onSubmitted,
    this.suffixIcon,
    this.height,
    Key? key,
  }) : super(key: key);
  void Function(String)? onChanged;
  void Function(String)? onSubmitted;
  TextEditingController controller;
  TextInputType? textInputType;
  String? hint;
  double? height;
  Color? labelColor;
  Color? borderColor;
  int maxLines;
  String? label;
  bool? secureText;
  bool showBorder;
  Color? backColor;
  Widget? suffix;
  Widget? prefixWidget;
  double? fontSize;
  Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        color: (backColor != null) ? backColor : Colors.transparent,
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        children: [
          if (prefixWidget != null)
            Row(
              children: [
                prefixWidget!,
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          Expanded(
            child: TextField(
              keyboardType: textInputType,
              inputFormatters: [
                if (textInputType == TextInputType.phone) ...[
                  FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*')),
                ],
              ],
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              controller: controller,
              maxLines: maxLines,
              obscureText: secureText ?? false,
              style: AppTextStyles.sanFransiscoDisplay(
                fontSize: (fontSize != null) ? fontSize : 10,
                fontWeight: FontWeight.normal,
                color: labelColor,
              ),
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                labelText: label,
                labelStyle: AppTextStyles.poppins(
                    style:  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: labelColor??borderColor)),
                //contentPadding: EdgeInsets.zero,
                hintText: hint,
                enabledBorder:  OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: borderColor??Colors.white)),
                focusedBorder:  OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: borderColor??Colors.white)),
                // border: const OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                //     borderSide: BorderSide(color: Colors.white)
                // ),
                // isDense: true,
                hintStyle: AppTextStyles.sanFransiscoDisplay(
                  fontSize: (fontSize != null) ? fontSize : 10,
                  fontWeight: FontWeight.normal,
                  color: CColors.textFieldHintColor,
                ),
              ),
            ),
          ),
          suffix ?? Container()
        ],
      ),
    );
  }
}
