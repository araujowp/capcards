import 'package:flutter/material.dart';

class SecondChanceWidget extends StatelessWidget {
  final VoidCallback onReviewPressed; // ← único parâmetro (o evento)

  const SecondChanceWidget({super.key, required this.onReviewPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.replay, size: 80, color: Colors.yellow),
          const SizedBox(height: 24),
          const Text(
            "Você terminou a primeira rodada!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: onReviewPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Vamos revisar alguns erros"),
          ),
        ],
      ),
    );
  }
}
