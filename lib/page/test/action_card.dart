import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const ActionCard({super.key, required this.onCorrect, required this.onWrong});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onCorrect,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, color: Colors.white, size: 32.0),
              SizedBox(height: 8.0),
              Text(
                'ACERTEI',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onWrong,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close, color: Colors.white, size: 32.0),
              SizedBox(height: 8.0),
              Text(
                'ERREI',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
