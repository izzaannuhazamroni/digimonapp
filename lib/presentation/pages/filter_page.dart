import 'package:flutter/material.dart';
import '../../domain/usecases/get_digimon_by_level.dart';
import '../widgets/digimon_card.dart';

class FilterPage extends StatefulWidget {
  final GetDigimonByLevel getDigimonByLevel;

  FilterPage({required this.getDigimonByLevel});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedLevel = 'Rookie';
  List digimons = [];
  bool isLoading = false;
  String? error;

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
      appBar: AppBar(
        title: Text('Filter Digimon by Level'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedLevel,
            items: ['Rookie', 'Champion', 'Ultimate', 'Mega']
                .map((level) => DropdownMenuItem(
                      value: level,
                      child: Text(level),
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
          if (isLoading) CircularProgressIndicator(),
          if (error != null) Text('Error: $error'),
          if (!isLoading && error == null)
            Expanded(
              child: ListView.builder(
                itemCount: digimons.length,
                itemBuilder: (context, index) {
                  return DigimonCard(digimon: digimons[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}
