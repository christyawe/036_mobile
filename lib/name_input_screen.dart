import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class NameInputScreen extends StatefulWidget {
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _controller = TextEditingController();

  void _startQuiz() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen(nama: name)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Masukkan nama terlebih dahulu!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Masukkan Nama')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Siapa yang akan mengikuti tes ini?', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama Lengkap'),
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: _startQuiz, child: Text('Mulai Tes')),
          ],
        ),
      ),
    );
  }
}
