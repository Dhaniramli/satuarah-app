import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchRideController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController inputan;

  var queryAwal = [].obs;
  var tempSearch = [].obs;
  RxBool isLoading = false.obs;

  late FocusNode textFormFieldFocusNode;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamtrip() async* {
    yield* firestore.collection('trip').where("trip_status",
        whereIn: ['Menunggu', 'Dalam Perjalanan']).snapshots();
  }

  Future<void> searchTrip(String data) async {
    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      isLoading(true);

      var startIndex = data.indexOf("Kecamatan") + "Kecamatan".length + 1;
      var capitalized =
          data.substring(startIndex, startIndex + 1).toUpperCase();

      if (queryAwal.isEmpty && data.length == 1) {
        //fungsi yang akan dijalankan pada satu huruf ketikan pertama
        CollectionReference trips = firestore.collection("trip");
        final keyNameResult = await trips
            .where("trip_status", whereIn: ['Menunggu', 'Dalam Perjalanan'])
            .where("key_finish", isEqualTo: capitalized)
            .get();

        if (keyNameResult.docs.isNotEmpty) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          isLoading(false);
        } else {
          isLoading(false);
          // Get.snackbar(
          //   "Tidak ditemukan",
          //   "Tidak ada tebengan dengan tujuan ini",
          //   duration: const Duration(seconds: 1),
          // );
        }
      }

      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];
        for (var element in queryAwal) {
          if (element["locality_finish"].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        }
      }
    }

    isLoading(false);
    queryAwal.refresh();
    tempSearch.refresh();
  }

  @override
  void onInit() {
    inputan = TextEditingController();
    textFormFieldFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    textFormFieldFocusNode.dispose();
    inputan.dispose();
    super.onClose();
  }
}
