class TripModel {
  final String chair;
  final String cityFinish;
  final String cityStart;
  final String otherInformation;
  final String tripDate;
  final String tripPrice;
  final String tripTime;

  TripModel({
    required this.chair,
    required this.cityFinish,
    required this.cityStart,
    required this.otherInformation,
    required this.tripDate,
    required this.tripPrice,
    required this.tripTime,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        chair: json["chair"],
        cityFinish: json["city_finish"],
        cityStart: json["city_start"],
        otherInformation: json["other_information"],
        tripDate: json["trip_date"],
        tripPrice: json["trip_price"],
        tripTime: json["trip_time"],
      );

  Map<String, dynamic> toJson() => {
        "chair": chair,
        "city_finish": cityFinish,
        "city_start": cityStart,
        "other_information": otherInformation,
        "trip_date": tripDate,
        "trip_price": tripPrice,
        "trip_time": tripTime,
      };
}
