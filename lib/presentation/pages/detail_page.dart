import 'package:flutter/material.dart';
import '../../domain/entities/digimon_entity.dart';

class DetailPage extends StatelessWidget {
  final DigimonEntity digimon;

  DetailPage({required this.digimon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(digimon.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(digimon.img),
            SizedBox(height: 16),
            Text(digimon.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(digimon.level,
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
