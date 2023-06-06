import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/user_model.dart';
import '../controllers/make_a_trip_controller.dart';
import 'widgets/city_widget.dart';
import 'widgets/dropdown_widget.dart';
import 'widgets/text_form_widget.dart';

class MakeATripView extends StatefulWidget {
  const MakeATripView({Key? key}) : super(key: key);

  @override
  State<MakeATripView> createState() => _MakeATripViewState();
}

class _MakeATripViewState extends State<MakeATripView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MakeATripController());
    final UserModel dataUser = Get.arguments;

    if (controller.idDriver.text == "") {
      controller.idDriver.text = dataUser.idUser;
    }
    if (controller.email.text == "") {
      controller.email.text = dataUser.email;
    }
    if (controller.fullName.text == "") {
      controller.fullName.text = dataUser.fullName;
    }
    if (controller.merekKendaraan.text == "") {
      controller.merekKendaraan.text = dataUser.merekKendaraan;
    }
    if (controller.nomorPlat.text == "") {
      controller.nomorPlat.text = dataUser.nomorPlat;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Perjalanan'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormWidget(
                label: "Nama",
                hintText: "Nama",
                controller: controller.fullName,
                obscureText: false,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormWidget(
                label: "Merek Kendaraan",
                hintText: "Merek Kendaraan",
                controller: controller.merekKendaraan,
                obscureText: false,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Merek wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormWidget(
                label: "Plat",
                hintText: "Nomor Plat",
                controller: controller.nomorPlat,
                obscureText: false,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plat wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Text(
                "Kota/Kabupaten Awal",
                style: textBlackDuaStyle.copyWith(
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
                style: textBlackDuaStyle.copyWith(
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
                style: textBlackDuaStyle.copyWith(
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
                style: textBlackDuaStyle.copyWith(
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
                controller: controller.tripPrice,
                obscureText: false,
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Biaya wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormWidget(
                label: "Keterangan Lain",
                hintText: "Contoh: gantian nyetir, sharing biaya tol dll",
                controller: controller.otherInformation,
                obscureText: false,
                maxLines: null,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.isLoading.toggle();
                      controller.doMakeATrip();
                      controller.isLoading(false);
                    }
                  },
                  child: Obx(
                    () => controller.isLoading.isFalse
                        ? Text(
                            'Buat',
                            style: textWhiteStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
