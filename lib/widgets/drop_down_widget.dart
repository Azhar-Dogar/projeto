import 'package:flutter/material.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.dropdownItems,
    required this.onSelect,
    required this.label,
    this.labelColor,
    this.borderColor,
    this.fontSize,
    this.selectedValue,
    this.isEdit = true,
  });

  final List<String> dropdownItems;
  final Function(String) onSelect;
  final String label;
  final bool isEdit;
  final Color? labelColor;
  final Color? borderColor;
  final double? fontSize;
  final String? selectedValue;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: DropdownButtonFormField<String>(
        value: selectedValue,

        isExpanded: true,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        items: widget.dropdownItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        onChanged: !widget.isEdit ? null : (String? newValue) {
          selectedValue = newValue;
          widget.onSelect(newValue!);
        },
        style: AppTextStyles.sanFransiscoDisplay(
            fontSize: (widget.fontSize != null) ? widget.fontSize : 14,
            fontWeight: FontWeight.normal,
            color: CColors.textColor
            // color: widget.labelColor,
            ),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: AppTextStyles.poppins(
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: widget.labelColor ?? CColors.labelColor,
            ),
          ),
          //contentPadding: EdgeInsets.zero,
          disabledBorder: border(),
          enabledBorder: border(),
          focusedBorder: border(),
        ),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide:
            BorderSide(color: widget.borderColor ?? CColors.textFieldBorder));
  }
}
