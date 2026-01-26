import 'package:flutter/material.dart';
import 'package:capcards/page/statistics/test_stats.dart';

class ResultPage extends StatelessWidget {
  final TestStats stats;

  const ResultPage(this.stats, {super.key});

  String getMessage(double percentage) {
    return switch (percentage) {
      <= 20 => "Você consegue melhorar",
      > 20 && <= 40 => "Está no caminho certo",
      > 40 && <= 60 => "Bom progresso, continue assim!",
      > 60 && <= 80 => "Muito bem! Quase lá!",
      _ => "Excelente desempenho! Parabéns!",
    };
  }

  @override
  Widget build(BuildContext context) {
    final int correctAnswers = stats.tries - stats.wrongs;
    final int totalQuestions = stats.tries;
    final double percentage =
        totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado do teste"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getMessage(percentage),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Acertos: $correctAnswers',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 16),
              Text(
                'Erros: ${stats.wrongs}',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 16),
              Text(
                'Total de questões: $totalQuestions',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 32),
              Text(
                'Aproveitamento: ${percentage.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
