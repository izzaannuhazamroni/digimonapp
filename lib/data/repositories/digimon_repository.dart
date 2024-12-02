import '../models/digimon_model.dart';

abstract class DigimonRepository {
  Future<List<DigimonModel>> getAllDigimon();
  Future<List<DigimonModel>> getDigimonByName(String name);
  Future<List<DigimonModel>> getDigimonByLevel(String level);
}
