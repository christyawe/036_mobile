import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyJson = prefs.getString('mbti_history');
    if (historyJson != null) {
      try {
        List decoded = jsonDecode(historyJson);
        setState(() {
          historyList = List<Map<String, dynamic>>.from(decoded.reversed);
        });
      } catch (e) {
        print("Gagal memuat riwayat: $e");
      }
    }
  }

  void _clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mbti_history');
    setState(() {
      historyList = [];
    });
  }

  void _hapusSatuRiwayat(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      historyList.removeAt(index);
    });
    // Simpan ulang ke shared preferences (reversed lagi biar urutannya tetap baru di atas)
    await prefs.setString('mbti_history', jsonEncode(historyList.reversed.toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Tes MBTI"),
        actions: [
          if (historyList.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _clearHistory,
              tooltip: "Hapus semua",
            )
        ],
      ),
      body: historyList.isEmpty
          ? Center(child: Text("Belum ada riwayat tes."))
          : ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final entry = historyList[index];
                final nama = entry['nama'] ?? 'Tidak diketahui';
                final tipe = entry['tipe'] ?? '???';

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(tipe[0], style: TextStyle(color: Colors.white)),
                    ),
                    title: Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Tipe MBTI: $tipe"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _hapusSatuRiwayat(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
