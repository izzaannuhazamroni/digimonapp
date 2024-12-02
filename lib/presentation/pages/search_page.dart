import 'package:flutter/material.dart';
import '../../domain/usecases/get_all_digimon.dart';
import '../widgets/digimon_card.dart';

class SearchPage extends StatefulWidget {
  final GetAllDigimon getAllDigimon;

  SearchPage({required this.getAllDigimon});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List digimons = []; // Semua data Digimon
  List filteredDigimons = []; // Hasil pencarian berdasarkan filter
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadAllDigimons(); // Ambil semua data Digimon saat halaman dimuat
  }

  Future<void> _loadAllDigimons() async {
    try {
      final results = await widget.getAllDigimon.execute();
      setState(() {
        digimons = results;
        filteredDigimons = results; // Awalnya tampilkan semua Digimon
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
      return name.contains(input); // Filter berdasarkan substring
    }).toList();

    setState(() {
      filteredDigimons = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Digimon'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter Digimon Name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _filterDigimons, // Pencarian real-time
            ),
          ),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else if (error != null)
            Center(child: Text('Error: $error'))
          else if (filteredDigimons.isEmpty)
            Center(child: Text('No results found'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredDigimons.length,
                itemBuilder: (context, index) {
                  return DigimonCard(digimon: filteredDigimons[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}
