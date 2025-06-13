import 'package:flutter/material.dart';
import 'questions.dart';

class QuizScreen extends StatefulWidget {
  final String nama;

  QuizScreen({required this.nama});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}


class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  Map<String, int> scores = {
    'EI': 0,
    'SN': 0,
    'TF': 0,
    'JP': 0,
  };

  void answerQuestion(int value) {
    String dimension = questions[currentIndex].dimension;
    setState(() {
      scores[dimension] = scores[dimension]! + value;
      currentIndex++;
    });

   if (currentIndex >= questions.length) {
  Navigator.pushReplacementNamed(
    context,
    '/result',
    arguments: {
      'scores': scores,
      'nama': widget.nama,
    },
  );
}

  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= questions.length) return SizedBox();

    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Pertanyaan ${currentIndex + 1}')),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question.text,
            style: TextStyle(fontSize: 20, color: Colors.pink[800]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(height: 20),
      ...[
        {'label': '💖 Sangat Setuju', 'value': 2},
        {'label': '👍 Setuju', 'value': 1},
        {'label': '😐 Netral', 'value': 0},
        {'label': '👎 Tidak Setuju', 'value': -1},
        {'label': '💔 Sangat Tidak Setuju', 'value': -2},
      ].map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ElevatedButton(
            onPressed: () => answerQuestion(option['value'] as int),
            child: Text(option['label'] as String),
          ),
        );
      }).toList()
    ],
  ),
),
    );
  }
}
