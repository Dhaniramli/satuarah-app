class TripModel {
  final String chair;
  final String cityFinish;
  final String cityStart;
  final String otherInformation;
  final String tripDate;
  final String tripPrice;
  final String tripTime;
  final String tripStatus;
  final String fullName;
  final String idDriver;
  final String email;
  final String nomorPlat;
  final String merekKendaraan;
  final String idTrip;
  final String photo;

  TripModel({
    required this.chair,
    required this.cityFinish,
    required this.cityStart,
    required this.otherInformation,
    required this.tripDate,
    required this.tripPrice,
    required this.tripTime,
    required this.tripStatus,
    required this.fullName,
    required this.idDriver,
    required this.email,
    required this.nomorPlat,
    required this.merekKendaraan,
    required this.idTrip,
    required this.photo,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        chair: json["chair"] ?? "",
        cityFinish: json["city_finish"] ?? "",
        cityStart: json["city_start"] ?? "",
        otherInformation: json["other_information"] ?? "",
        tripDate: json["trip_date"] ?? "",
        tripPrice: json["trip_price"] ?? "",
        tripTime: json["trip_time"] ?? "",
        tripStatus: json["trip_status"] ?? "",
        fullName: json["full_name"] ?? "",
        idDriver: json["id_driver"] ?? "",
        email: json["email"] ?? "",
        nomorPlat: json["nomor_plat"] ?? "",
        merekKendaraan: json["merek_kendaraan"] ?? "",
        idTrip: json["id_trip"] ?? "",
        photo: json["photo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chair": chair,
        "city_finish": cityFinish,
        "city_start": cityStart,
        "other_information": otherInformation,
        "trip_date": tripDate,
        "trip_price": tripPrice,
        "trip_time": tripTime,
        "trip_status": tripStatus,
        "full_name": fullName,
        "id_driver": idDriver,
        "email": email,
        "nomor_plat": nomorPlat,
        "merek_kendaraan": merekKendaraan,
        "id_trip": idTrip,
        "photo": photo,
      };
}
