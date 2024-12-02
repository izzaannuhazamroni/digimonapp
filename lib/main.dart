import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import dari direktori baru di bawah lib/
import 'package:digimon_app/presentation/pages/home_page.dart';
import 'package:digimon_app/presentation/pages/search_page.dart';
import 'package:digimon_app/presentation/pages/filter_page.dart';
import 'package:digimon_app/data/datasources/digimon_remote_datasource.dart';
import 'package:digimon_app/data/repositories/digimon_repository_impl.dart';
import 'package:digimon_app/domain/usecases/get_all_digimon.dart';
import 'package:digimon_app/domain/usecases/get_digimon_by_name.dart';
import 'package:digimon_app/domain/usecases/get_digimon_by_level.dart';
import 'package:digimon_app/core/network/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive
  await Hive.initFlutter();

  // Inisialisasi dependensi
  final dio = ApiClient.createClient();
  final remoteDataSource = DigimonRemoteDataSource(dio);
  final repository = DigimonRepositoryImpl(remoteDataSource);

  final getAllDigimon = GetAllDigimon(repository);
  final getDigimonByName = GetDigimonByName(repository);
  final getDigimonByLevel = GetDigimonByLevel(repository);

  runApp(MyApp(
    getAllDigimon: getAllDigimon,
    getDigimonByName: getDigimonByName,
    getDigimonByLevel: getDigimonByLevel,
  ));
}

class MyApp extends StatelessWidget {
  final GetAllDigimon getAllDigimon;
  final GetDigimonByName getDigimonByName;
  final GetDigimonByLevel getDigimonByLevel;

  MyApp({
    required this.getAllDigimon,
    required this.getDigimonByName,
    required this.getDigimonByLevel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digimon App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Menggunakan sistem mode (light/dark)
      home: HomePage(getAllDigimon: getAllDigimon),
      routes: {
        '/search': (context) => SearchPage(getAllDigimon: getAllDigimon),
        '/filter': (context) =>
            FilterPage(getDigimonByLevel: getDigimonByLevel),
      },
    );
  }
}
