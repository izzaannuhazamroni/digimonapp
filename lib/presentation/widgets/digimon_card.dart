import 'package:flutter/material.dart';
import '../../domain/entities/digimon_entity.dart';

class DigimonCard extends StatelessWidget {
  final DigimonEntity digimon;
  final VoidCallback? onTap;

  DigimonCard({required this.digimon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: Image.network(
            digimon.img,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(digimon.name),
          subtitle: Text(digimon.level),
        ),
      ),
    );
  }
}
