import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme.dart';

class DisclaimerView extends StatelessWidget {
  const DisclaimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: const Text(
            "",
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text(
              "Syarat & ketentuan\n",
              style:
                  textBlackDuaStyle.copyWith(fontSize: 18.0, fontWeight: bold),
            ),
            Text(
              'Konten dalam App ini dibuat dengan tujuan memberikan informasi tebengan. Kami berusaha untuk memberikan informasi yang akurat yang dibutuhkan.\n\nSemua materi yang dipublikasikan di sini adalah milik pribadi kami dan tidak boleh dipublikasikan, direproduksi, atau didistribusikan tanpa izin tertulis dari kami.\n\nKami juga tidak bertanggung jawab atas segala bentuk kerugian atau kerusakan yang mungkin terjadi sebagai akibat dari penggunaan informasi yang diterbitkan di aplikasi ini',
              // textAlign: TextAlign.justify,
              style: textBlackDuaStyle.copyWith(
                  fontSize: 15.0, fontWeight: regular),
            ),
            Text(
              "\nPrivasi\n",
              style:
                  textBlackDuaStyle.copyWith(fontSize: 18.0, fontWeight: bold),
            ),
            Text(
              'Kami menghargai privasi pengguna kami dan berkomitmen untuk melindungi data pribadi Anda. Kebijakan privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda saat Anda menggunakan aplikasi Satuarah.\n\nInformasi apa yang kami kumpulkan?\n\nKami dapat mengumpulkan informasi pribadi yang Anda berikan kepada kami, seperti nama, alamat email, nomor telepon, dan informasi kendaraan yang relevan. Kami juga dapat mengumpulkan informasi tentang penggunaan Anda dari aplikasi Satuarah, seperti riwayat pencarian, riwayat tebengan, dan interaksi Anda dengan aplikasi.\n\nBagaimana kami menggunakan informasi tersebut?\n\nKami menggunakan informasi yang kami kumpulkan untuk menyediakan layanan dan fungsionalitas yang diminta oleh pengguna, untuk mengirimkan informasi tebengan yang relevan, dan untuk meningkatkan kualitas dan fungsionalitas aplikasi Satuarah. Kami juga dapat menggunakan informasi untuk menghubungi pengguna tentang perubahan atau peningkatan pada aplikasi, untuk mengirimkan pemberitahuan, dan untuk keperluan administratif lainnya.\n\nKami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga tanpa izin Anda. Namun, kami dapat membagikan informasi kepada pihak ketiga jika diperlukan untuk memenuhi kewajiban hukum, untuk melindungi hak, properti, atau keselamatan kami atau orang lain, atau untuk mengurangi risiko penipuan atau kejahatan lainnya.\n\nBagaimana kami melindungi informasi Anda?\n\nKami mengambil langkah-langkah keamanan yang wajar untuk melindungi informasi pribadi Anda dari akses yang tidak sah, penggunaan, atau pengungkapan yang tidak sah. Kami menggunakan metode enkripsi untuk mengamankan data sensitif dan memperbarui sistem kami secara teratur untuk menjaga keamanan informasi.\n\nBagaimana Anda dapat mengakses atau memperbarui informasi Anda?\n\nAnda dapat mengakses dan memperbarui informasi pribadi Anda kapan saja melalui aplikasi Satuarah. \n\nPerubahan pada Kebijakan Privasi\n\nKami dapat memperbarui kebijakan privasi ini dari waktu ke waktu. Jika kami melakukan perubahan signifikan pada kebijakan privasi, kami akan memberikan pemberitahuan yang sesuai kepada pengguna melalui email atau melalui pemberitahuan pada aplikasi.\n\nTerima kasih telah menggunakan aplikasi Satuarah. Kami berkomitmen untuk melindungi privasi Anda dan menjaga kerahasiaan informasi yang Anda berikan kepada kami dengan tegas.',
              style: textBlackDuaStyle.copyWith(
                  fontSize: 15.0, fontWeight: regular),
              // textAlign: TextAlign.justify,
            ),
          ],
        ));
  }
}
