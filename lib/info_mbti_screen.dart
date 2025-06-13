import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoMBTIScreen extends StatelessWidget {
  final List<Map<String, String>> mbtiList = [
    {
      'type': 'INTJ',
      'name': 'Arsitek',
      'image': 'assets/images/INTJ.jpg',
      'description':
          'Pemikir imajinatif dan strategis yang menyusun rencana untuk segalanya.'
    },
    {
      'type': 'INTP',
      'name': 'Ahli Logika',
      'image': 'assets/images/INTP.jpg',
      'description':
          'Penemu inovatif yang haus akan pengetahuan dan selalu mencari pemahaman baru.'
    },
    {
      'type': 'ENTJ',
      'name': 'Komandan',
      'image': 'assets/images/ENTJ.jpg',
      'description':
          'Pemimpin yang pemberani, imajinatif, dan memiliki determinasi tinggi.'
    },
    {
      'type': 'ENTP',
      'name': 'Ahli Debat',
      'image': 'assets/images/ENTP.jpg',
      'description':
          'Pemikir cerdas dan penuh rasa ingin tahu yang tidak bisa menolak tantangan intelektual.'
    },
    {
      'type': 'INFJ',
      'name': 'Advokat',
      'image': 'assets/images/INFJ.jpg',
      'description':
          'Pendiam dan penuh inspirasi, memiliki tekad kuat untuk menciptakan dampak positif.'
    },
    {
      'type': 'INFP',
      'name': 'Mediator',
      'image': 'assets/images/INFP.jpg',
      'description':
          'Penuh empati dan imajinasi, selalu mencari makna dan hubungan yang mendalam.'
    },
    {
      'type': 'ENFJ',
      'name': 'Protagonis',
      'image': 'assets/images/ENFJ.jpg',
      'description':
          'Pemimpin karismatik, menginspirasi orang lain menuju kebaikan bersama.'
    },
    {
      'type': 'ENFP',
      'name': 'Kampanye',
      'image': 'assets/images/ENFP.jpg',
      'description':
          'Antusias, kreatif, dan sosial. Selalu mencari pengalaman baru dan hubungan bermakna.'
    },
    {
      'type': 'ISTJ',
      'name': 'Logistikus',
      'image': 'assets/images/ISTJ.jpg',
      'description':
          'Orang yang praktis dan berorientasi pada fakta, sangat dapat diandalkan.'
    },
    {
      'type': 'ISFJ',
      'name': 'Pelindung',
      'image': 'assets/images/ISFJ.jpg',
      'description':
          'Pendiam namun sangat hangat, penuh dedikasi dan tanggung jawab.'
    },
    {
      'type': 'ESTJ',
      'name': 'Direktur',
      'image': 'assets/images/ESTJ.jpg',
      'description':
          'Manajer yang sangat baik, berorientasi pada hasil dan struktur.'
    },
    {
      'type': 'ESFJ',
      'name': 'Konsul',
      'image': 'assets/images/ESFJ.jpg',
      'description':
          'Penuh perhatian, setia, dan sangat sosial, suka membantu orang lain.'
    },
    {
      'type': 'ISTP',
      'name': 'Virtuoso',
      'image': 'assets/images/ISTP.jpg',
      'description':
          'Eksperimen dan analitis, suka memecahkan masalah secara praktis.'
    },
    {
      'type': 'ISFP',
      'name': 'Petualang',
      'image': 'assets/images/ISFP.jpg',
      'description':
          'Seniman tenang yang suka mengeksplorasi dan mengekspresikan diri dengan cara unik.'
    },
    {
      'type': 'ESTP',
      'name': 'Pengusaha',
      'image': 'assets/images/ESTP.jpg',
      'description':
          'Enerjik dan suka aksi, menyukai kehidupan yang dinamis dan tantangan langsung.'
    },
    {
      'type': 'ESFP',
      'name': 'Penghibur',
      'image': 'assets/images/ESFP.jpg',
      'description':
          'Suka bersenang-senang, penuh semangat dan suka berada di tengah keramaian.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F6),
      appBar: AppBar(
        title: Text(
          "Info MBTI 💫",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: mbtiList.length,
        itemBuilder: (context, index) {
          final tipe = mbtiList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    tipe['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 3 / 4, // 4:3 ratio
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tipe['type']} - ${tipe['name']}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        tipe['description']!,
                        style: GoogleFonts.poppins(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
