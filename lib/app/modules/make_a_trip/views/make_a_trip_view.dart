import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../../theme.dart';
import '../../../data/models/city_model.dart';
import '../controllers/make_a_trip_controller.dart';
import 'widgets/city_widget.dart';
import 'widgets/dropdown_widget.dart';
import 'widgets/text_form_widget.dart';

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MakeATripView extends StatefulWidget {
  const MakeATripView({Key? key}) : super(key: key);

  @override
  State<MakeATripView> createState() => _MakeATripViewState();
}

class _MakeATripViewState extends State<MakeATripView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MakeATripController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Perjalanan'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kota/Kabupaten Awal",
              style: textGrayStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            const SizedBox(height: 7),
            CityWidget(
              onChanged: (City? city) {
                setState(() {
                  controller.cityStart = city!.cityName ?? "";
                });
              },
              hintText: "Kota/Kabupaten Awal",
            ),
            const SizedBox(height: 15),
            Text(
              "Kota/Kabupaten Tujuan",
              style: textGrayStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            const SizedBox(height: 7),
            CityWidget(
              onChanged: (City? city) {
                setState(() {
                  controller.cityFinish = city!.cityName ?? "";
                });
              },
              hintText: "Kota/Kabupaten Tujuan",
            ),
            const SizedBox(height: 15),
            Text(
              "Kursi",
              style: textGrayStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            const SizedBox(height: 7),
            DropdownWidget(
              hintText: "Kursi",
              selectItem: controller.chair != "" ? controller.chair : null,
              items: const [
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9",
                "10",
              ],
              valueC: (value) {
                if (value != null) {
                  controller.chair = value;
                }
              },
            ),
            const SizedBox(height: 15),
            Text(
              "Waktu",
              style: textGrayStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            const SizedBox(height: 7),
            InkWell(
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickeddate != null) {
                  setState(() {
                    controller.tripDate.text =
                        DateFormat('dd/MM/yyyy').format(pickeddate);
                  });
                }
              },
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: primaryColor,
                    border: Border.all(color: grayTigaColor)),
                child: Row(
                  children: [
                    Expanded(
                        child: controller.tripDate.text == ""
                            ? const Text("Tanggal")
                            : Text(controller.tripDate.text)),
                    const Spacer(),
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: grayTigaColor,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 10, minute: 30),
                );

                if (pickedTime != null) {
                  setState(() {
                    controller.tripTime.text = pickedTime.format(context);
                  });
                }
              },
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: primaryColor,
                    border: Border.all(color: grayTigaColor)),
                child: Row(
                  children: [
                    Expanded(
                      child: controller.tripTime.text == ""
                          ? const Text("Jam")
                          : Text(controller.tripTime.text),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.av_timer_rounded,
                      size: 20,
                      color: grayTigaColor,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormWidget(
              label: "Biaya",
              hintText: "Biaya Perjalanan",
              // controller: controller.nomorKtp,
              obscureText: false,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor KTP wajib diisi';
                } else if (!RegExp(r'^[0-9]{16}$').hasMatch(value)) {
                  return 'Format nomor KTP tidak valid. Nomor KTP harus terdiri dari 16 digit angka.';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            const TextFormWidget(
              label: "Keterangan Lain",
              hintText: "Contoh: gantian nyetir, sharing biaya tol dll",
              // controller: controller.nomorKtp,
              obscureText: false,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
