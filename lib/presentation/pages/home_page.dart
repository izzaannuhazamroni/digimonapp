import 'package:flutter/material.dart';
import '../../domain/usecases/get_all_digimon.dart';
import '../widgets/digimon_card.dart';
import '../widgets/digimon_shimmer.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final GetAllDigimon getAllDigimon;

  HomePage({required this.getAllDigimon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Digimon')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Digimon App', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('All Digimon'),
              onTap: () {
                Navigator.pop(context); // Tetap di halaman ini
              },
            ),
            ListTile(
              title: Text('Search Digimon'),
              onTap: () {
                Navigator.pushNamed(context, '/search'); // Navigasi ke Search Page
              },
            ),
            ListTile(
              title: Text('Filter Digimon'),
              onTap: () {
                Navigator.pushNamed(context, '/filter'); // Navigasi ke Filter Page
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.pushNamed(context, '/search'); // Navigasi ke Search Page
        },
      ),
      body: FutureBuilder(
        future: getAllDigimon.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DigimonShimmer(); // Efek loading dengan shimmer
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No Digimon found.'));
          } else {
            final digimons = snapshot.data as List;
            return ListView.builder(
              itemCount: digimons.length,
              itemBuilder: (context, index) {
                return DigimonCard(
                  digimon: digimons[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(digimon: digimons[index]),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
