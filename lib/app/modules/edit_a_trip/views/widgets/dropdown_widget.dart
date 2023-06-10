// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:satuarah/theme.dart';

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String? selectItem;
  final void Function(String?)? valueC;
  final Future<List<String>> Function(String)? asyncItems;

  const DropdownWidget({
    super.key,
    required this.hintText,
    this.selectItem,
    required this.items,
    this.valueC,
    this.asyncItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding:
          const EdgeInsets.only(right: 5.0, left: 15.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: grayTigaColor)),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
        ),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle:
              textBlackDuaStyle.copyWith(fontSize: 15, fontWeight: regular),
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            hintText: hintText,
            hintStyle: textGrayStyle.copyWith(
              fontSize: 15,
              fontWeight: regular,
            ),
          ),
        ),
        selectedItem: selectItem,
        onChanged: valueC,
        asyncItems: asyncItems,
      ),
    );
  }
}
