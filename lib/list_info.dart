import 'package:flutter/material.dart';

class ListInfoPage extends StatelessWidget {
  const ListInfoPage({super.key});

  final List<String> infos = const [
  "Buka halaman Home aplikasi",
  "Buka menu lewat tombol garis tiga di kiri atas",
  "Ketik pertanyaan atau ide di kotak chat",
  "Jika ingin memakai gambar, tekan ikon kamera lalu pilih gambar",
  "Tekan tombol Send untuk mengirim pesan atau gambar",
  "Jawaban Gemini AI akan muncul di bawah pesan kamu",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Petunjuk Cara Pakai Gemini AI")),
      body: ListView.builder(
        itemCount: infos.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF72A8FF)),
              title: Text(infos[index]),
            ),
          );
        },
      ),
    );
  }
}
