class UserModel {
  final String email;
  final String fullName;
  final String idUser;
  final String merekKendaraan;
  final String nomorKtp;
  final String nomorPlat;
  final String nomorSim;
  final String phoneNumber;
  final String userAs;
  final String photo;

  UserModel({
    required this.email,
    required this.fullName,
    required this.idUser,
    required this.merekKendaraan,
    required this.nomorKtp,
    required this.nomorPlat,
    required this.nomorSim,
    required this.phoneNumber,
    required this.userAs,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] ?? "",
        fullName: json["full_name"] ?? "",
        idUser: json["id_user"] ?? "",
        merekKendaraan: json["merek_kendaraan"] ?? "",
        nomorKtp: json["nomor_ktp"] ?? "",
        nomorPlat: json["nomor_plat"] ?? "",
        nomorSim: json["nomor_sim"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        userAs: json["user_as"] ?? "",
        photo: json["photo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "full_name": fullName,
        "id_user": idUser,
        "merek_kendaraan": merekKendaraan,
        "nomor_ktp": nomorKtp,
        "nomor_plat": nomorPlat,
        "nomor_sim": nomorSim,
        "phone_number": phoneNumber,
        "user_as": userAs,
        "photo": photo,
      };
}
