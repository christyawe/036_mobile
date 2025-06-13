import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'name_input_screen.dart';
import 'history_screen.dart';
import 'info_mbti_screen.dart';
import 'main.dart'; 

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  String randomMotivation = '';
  String randomFact = '';

  final List<String> motivations = [
    "Kamu luar biasa, jangan ragu untuk bersinar! ✨",
    "Terus semangat ya, hari ini milikmu! 💪",
    "Jangan lupa senyum, kamu pantas bahagia 🌸",
    "Percaya diri itu kunci! 🔑",
    "Hari ini lebih baik dari kemarin! ☀️",
  ];

  final List<String> mbtiFacts = [
    "INFJ adalah tipe paling langka, hanya sekitar 1% populasi 🌍",
    "ENFP punya energi tinggi dan senang eksplorasi! 🌟",
    "ISTP dikenal sebagai problem solver handal 🔧",
    "INFP punya imajinasi luar biasa 💭",
    "ENTJ sering disebut natural-born leader 🧠👑",
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _generateRandomMessages();
  }

  void _generateRandomMessages() {
    final random = Random();
    setState(() {
      randomMotivation = motivations[random.nextInt(motivations.length)];
      randomFact = mbtiFacts[random.nextInt(mbtiFacts.length)];
    });
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      drawer: _buildDrawer(themeProvider),
      appBar: AppBar(
        title: Text("Halo, $username!",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: isDark ? null : Colors.pinkAccent.shade100,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : LinearGradient(
                  colors: [Colors.pink.shade50, Colors.blue.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/home_cute.jpeg',
                height: 180,
              ),
              SizedBox(height: 30),
              Text(
                'Selamat Datang di Tes MBTI 💖',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.purple.shade400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tekan menu di atas untuk mulai yaa~ ✨',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDark ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              SizedBox(height: 40),
              _buildSectionCard(
                icon: Icons.favorite,
                title: "Motivasi Harimu 💌",
                content: randomMotivation,
                isDark: isDark,
              ),
              SizedBox(height: 20),
              _buildSectionCard(
                icon: Icons.psychology,
                title: "Fun Fact MBTI 🧠",
                content: randomFact,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String content,
    required bool isDark,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: isDark ? Colors.grey[850] : Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.purple),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    content,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDark ? Colors.grey[300] : Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(ThemeProvider themeProvider) {
    final isDark = themeProvider.isDarkMode;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : LinearGradient(
                  colors: [Colors.pink.shade100, Colors.purple.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.pinkAccent.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    username,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildMenuItem(Icons.quiz, "Mulai Tes Kepribadian", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NameInputScreen()));
            }),
            _buildMenuItem(Icons.history, "Riwayat Tes", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => HistoryScreen()));
            }),
            _buildMenuItem(Icons.info_outline, "Info MBTI", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => InfoMBTIScreen()));
            }),
            _buildMenuItem(Icons.settings, "Ganti Tema", () {
              themeProvider.toggleTheme();
              Navigator.pop(context); // close drawer
            }),
            Divider(),
            _buildMenuItem(Icons.logout, "Keluar", _logout),
          ],
        ),
      ),
    );
  }

  ListTile _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple.shade400),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
