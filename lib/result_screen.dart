import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'history_screen.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, int> scores;
  final String nama;

  ResultScreen({required this.scores, required this.nama});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String mbtiType;
  late String description;

  @override
  void initState() {
    super.initState();
    _hitungMBTI();
    _simpanRiwayat(widget.nama, mbtiType); // dipanggil setelah mbtiType dihitung

    // Setelah 3 detik pindah ke HistoryScreen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => HistoryScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  void _hitungMBTI() {
    String getLetter(String key, String option1, String option2) {
      return widget.scores[key]! >= 0 ? option1 : option2;
    }

    mbtiType = getLetter('EI', 'E', 'I') +
        getLetter('SN', 'S', 'N') +
        getLetter('TF', 'T', 'F') +
        getLetter('JP', 'J', 'P');

    description = mbtiDescriptions[mbtiType] ?? "Tipe tidak ditemukan.";
  }

  void _simpanRiwayat(String nama, String tipeMBTI) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyJson = prefs.getString('mbti_history');
    List history = historyJson != null ? jsonDecode(historyJson) : [];

    history.add({"nama": nama, "tipe": tipeMBTI});
    await prefs.setString('mbti_history', jsonEncode(history));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hasil Tes')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Tipe Kepribadian ${widget.nama}:",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              mbtiType,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 24),
            Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, String> mbtiDescriptions = {
  'INTJ': 'Arsitek - Tipe pemikir strategis, penuh perencanaan dan logika.',
  'INTP': 'Logician - Inovatif dan haus akan pengetahuan.',
  'ENTJ': 'Komandan - Pemimpin alami, tegas dan percaya diri.',
  'ENTP': 'Debater - Pintar berargumen dan suka tantangan intelektual.',
  'INFJ': 'Advokat - Idealis dan memiliki wawasan mendalam.',
  'INFP': 'Mediator - Empatik dan sangat imajinatif.',
  'ENFJ': 'Protagonis - Pemimpin karismatik dan menginspirasi.',
  'ENFP': 'Kampanye - Energik, antusias, dan suka eksplorasi.',
  'ISTJ': 'Logistikus - Bertanggung jawab dan berorientasi detail.',
  'ISFJ': 'Pelindung - Setia, perhatian, dan berdedikasi.',
  'ESTJ': 'Direktur - Praktis, realistis, dan terorganisir.',
  'ESFJ': 'Konsul - Suka menolong dan sangat sosial.',
  'ISTP': 'Virtuoso - Suka eksplorasi praktis dan logis.',
  'ISFP': 'Petualang - Artistik, tenang, dan fleksibel.',
  'ESTP': 'Pengusaha - Spontan dan suka aksi.',
  'ESFP': 'Penghibur - Ceria dan suka menjadi pusat perhatian.',
};
