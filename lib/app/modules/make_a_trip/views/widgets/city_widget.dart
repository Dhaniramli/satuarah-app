import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../theme.dart';
import '../../../../data/models/city_model.dart';

class CityWidget extends StatefulWidget {
  final void Function(City?)? onChanged;
  final String hintText;

  const CityWidget({
    super.key,
    this.onChanged,
    required this.hintText,
  });

  @override
  State<CityWidget> createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding:
          const EdgeInsets.only(right: 5.0, left: 15.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: grayTigaColor)),
      child: DropdownSearch<City>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle:
              textBlackDuaStyle.copyWith(fontSize: 15, fontWeight: regular),
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            hintText: widget.hintText,
            hintStyle: textGrayStyle.copyWith(
              fontSize: 15,
              fontWeight: regular,
            ),
          ),
        ),
        asyncItems: (String filter) async {
          Uri url =
              Uri.parse("https://api.rajaongkir.com/starter/city?province=28");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "b1001cc0089b53bc6c7f628d7112ce2e",
              },
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            // print(err);
            return List<City>.empty();
          }
        },
        itemAsString: (City city) => "${city.type} ${city.cityName}",
        onChanged: widget.onChanged,
      ),
    );
  }
}
