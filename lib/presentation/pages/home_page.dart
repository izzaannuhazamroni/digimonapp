import 'package:flutter/material.dart';
import '../../domain/usecases/get_all_digimon.dart';
import '../widgets/digimon_card.dart';
import '../widgets/digimon_shimmer.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  final GetAllDigimon getAllDigimon;

  const HomePage({Key? key, required this.getAllDigimon}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 3 columns matches the 3x3 trading card binder pocket sheet from the reference image
  int _crossAxisCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xFF1B234B),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD500),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'DIGIMON',
                style: TextStyle(
                  color: Color(0xFF1B234B),
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Card Collection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _crossAxisCount == 3 ? '2 Kolom (Besar)' : '3 Kolom (Album Binder)',
            icon: Icon(_crossAxisCount == 3 ? Icons.grid_view : Icons.view_comfy),
            onPressed: () {
              setState(() {
                _crossAxisCount = _crossAxisCount == 3 ? 2 : 3;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B234B), Color(0xFF2E3D85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD500),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'DIGIMON CARD',
                      style: TextStyle(
                        color: Color(0xFF1B234B),
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Carddass Album Binder',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text('All Cards (Album)'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search Digimon'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('Filter by Level'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/filter');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: widget.getAllDigimon.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DigimonShimmer(crossAxisCount: _crossAxisCount);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No Digimon found.'));
          } else {
            final digimons = snapshot.data as List;
            return Container(
              // Binder page styling with light texture / sleeve pocket appearance
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3F6),
                border: Border(
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 6,
                  ),
                ),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: _crossAxisCount == 3 ? 6.0 : 10.0,
                  mainAxisSpacing: _crossAxisCount == 3 ? 8.0 : 12.0,
                ),
                itemCount: digimons.length,
                itemBuilder: (context, index) {
                  return DigimonCard(
                    digimon: digimons[index],
                    cardNumber: index + 1,
                    compact: _crossAxisCount >= 3,
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
            );
          }
        },
      ),
    );
  }
}
