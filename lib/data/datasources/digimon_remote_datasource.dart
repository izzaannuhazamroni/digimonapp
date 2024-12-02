import 'package:dio/dio.dart';
import '../models/digimon_model.dart';

class DigimonRemoteDataSource {
  final Dio client;

  DigimonRemoteDataSource(this.client);

  Future<List<DigimonModel>> fetchAllDigimon() async {
    final response =
        await client.get('https://digimon-api.vercel.app/api/digimon');
    return (response.data as List)
        .map((json) => DigimonModel.fromJson(json))
        .toList();
  }

  Future<List<DigimonModel>> fetchDigimonByName(String name) async {
    final response = await client
        .get('https://digimon-api.vercel.app/api/digimon/name/$name');
    return (response.data as List)
        .map((json) => DigimonModel.fromJson(json))
        .toList();
  }

  Future<List<DigimonModel>> fetchDigimonByLevel(String level) async {
    final response = await client
        .get('https://digimon-api.vercel.app/api/digimon/level/$level');
    return (response.data as List)
        .map((json) => DigimonModel.fromJson(json))
        .toList();
  }
}
