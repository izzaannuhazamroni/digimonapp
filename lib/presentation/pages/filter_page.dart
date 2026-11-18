import 'package:flutter/material.dart';
import '../../domain/usecases/get_digimon_by_level.dart';
import '../widgets/digimon_card.dart';
import 'detail_page.dart';

class FilterPage extends StatefulWidget {
  final GetDigimonByLevel getDigimonByLevel;

  const FilterPage({Key? key, required this.getDigimonByLevel}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedLevel = 'Rookie';
  List digimons = [];
  bool isLoading = false;
  String? error;

  final List<String> levels = [
    'Fresh',
    'In Training',
    'Rookie',
    'Champion',
    'Ultimate',
    'Mega',
    'Armor',
  ];

  void filter() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final results = await widget.getDigimonByLevel.execute(selectedLevel);
      setState(() {
        digimons = results;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    filter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B234B),
        foregroundColor: Colors.white,
        title: const Text('Filter by Level'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                const Text(
                  'Pilih Level: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF1B234B)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedLevel,
                        isExpanded: true,
                        items: levels
                            .map((level) => DropdownMenuItem(
                                  value: level,
                                  child: Text(
                                    level,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedLevel = value;
                            });
                            filter();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (error != null)
            Expanded(child: Center(child: Text('Error: $error')))
          else if (digimons.isEmpty)
            const Expanded(
              child: Center(
                child: Text('Tidak ada Digimon di level ini.'),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: digimons.length,
                itemBuilder: (context, index) {
                  return DigimonCard(
                    digimon: digimons[index],
                    cardNumber: index + 1,
                    compact: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          digimon: digimons[index],
                          cardNumber: index + 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
