import 'package:flutter/material.dart';
import '../../domain/entities/digimon_entity.dart';
import '../widgets/digimon_card.dart';

class DetailPage extends StatelessWidget {
  final DigimonEntity digimon;
  final int? cardNumber;

  const DetailPage({
    Key? key,
    required this.digimon,
    this.cardNumber,
  }) : super(key: key);

  int get _dpValue {
    switch (digimon.level.toLowerCase()) {
      case 'fresh':
        return 10;
      case 'in-training':
        return 20;
      case 'rookie':
        return 30;
      case 'champion':
        return 45;
      case 'ultimate':
        return 65;
      case 'mega':
        return 90;
      default:
        return 25;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardNo = cardNumber ?? 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1B234B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          digimon.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            // Prominent Full Trading Card
            Center(
              child: SizedBox(
                width: 250,
                child: Hero(
                  tag: 'card_${digimon.name}_$cardNo',
                  child: DigimonCard(
                    digimon: digimon,
                    cardNumber: cardNo,
                    compact: false,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Card Stats Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                children: [
                  _buildStatRow(
                    label: 'Card Number',
                    value: '#${cardNo.toString().padLeft(3, '0')}',
                    icon: Icons.tag,
                  ),
                  const Divider(color: Colors.white12),
                  _buildStatRow(
                    label: 'Digimon Name',
                    value: digimon.name,
                    icon: Icons.pets,
                  ),
                  const Divider(color: Colors.white12),
                  _buildStatRow(
                    label: 'Level / Stage',
                    value: digimon.level,
                    icon: Icons.trending_up,
                  ),
                  const Divider(color: Colors.white12),
                  _buildStatRow(
                    label: 'Digimon Power (DP)',
                    value: '$_dpValue DP',
                    icon: Icons.bolt,
                    valueColor: const Color(0xFFFFD500),
                  ),
                  const Divider(color: Colors.white12),
                  _buildStatRow(
                    label: 'Series',
                    value: 'Introductory Series 1',
                    icon: Icons.collections_bookmark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required String label,
    required String value,
    required IconData icon,
    Color valueColor = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
