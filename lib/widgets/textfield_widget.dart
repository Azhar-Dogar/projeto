import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extras/app_assets.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import 'custom_asset_image.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
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
    this.enabled,
    this.textColor,
    Key? key,
  }) : super(key: key);
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? hint;
  final double? height;
  final Color? labelColor;
  final Color? borderColor;
  final int maxLines;
  final String? label;
  final bool? secureText;
  final bool showBorder;
  final Color? backColor;
  final Widget? suffix;
  final Widget? prefixWidget;
  final double? fontSize;
  final Widget? suffixIcon;
  final bool? enabled;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        color: backColor ?? Colors.transparent,
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              enabled: enabled,
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
                color: textColor ?? labelColor,
              ),
              decoration: InputDecoration(
                suffixIcon: suffixIcon ?? (enabled != null && enabled!  ? Transform.scale(
                    scale: 0.5,
                    child: CustomAssetImage(
                      path: AppIcons.edit,
                      height: 10,
                      width: 10,
                    )) : null) ,
                labelText: label,
                labelStyle: AppTextStyles.poppins(
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: labelColor ?? CColors.labelColor)),
                //contentPadding: EdgeInsets.zero,
                disabledBorder: border(),
                enabledBorder: border(),
                focusedBorder: border(),
                hintText: hint,
                hintStyle: AppTextStyles.sanFransiscoDisplay(
                  fontSize: (fontSize != null) ? fontSize : 10,
                  fontWeight: FontWeight.w400,
                  color: CColors.textFieldBorder,
                ),
              ),
            ),
          ),
          // suffix ?? Container()
        ],
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor ?? CColors.textFieldBorder));
  }
}
