import 'package:flutter/material.dart';
import '../../domain/usecases/get_all_digimon.dart';
import '../widgets/digimon_card.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  final GetAllDigimon getAllDigimon;

  const SearchPage({Key? key, required this.getAllDigimon}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List digimons = [];
  List filteredDigimons = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadAllDigimons();
  }

  Future<void> _loadAllDigimons() async {
    try {
      final results = await widget.getAllDigimon.execute();
      setState(() {
        digimons = results;
        filteredDigimons = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _filterDigimons(String query) {
    final filtered = digimons.where((digimon) {
      final name = digimon.name.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();

    setState(() {
      filteredDigimons = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B234B),
        foregroundColor: Colors.white,
        title: const Text('Search Cards'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Cari nama Digimon (e.g. Agumon)...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1B234B)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF1B234B)),
                ),
              ),
              onChanged: _filterDigimons,
            ),
          ),
          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (error != null)
            Expanded(child: Center(child: Text('Error: $error')))
          else if (filteredDigimons.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Kartu Digimon tidak ditemukan',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: filteredDigimons.length,
                itemBuilder: (context, index) {
                  return DigimonCard(
                    digimon: filteredDigimons[index],
                    cardNumber: index + 1,
                    compact: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          digimon: filteredDigimons[index],
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
