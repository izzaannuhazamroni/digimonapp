import '../datasources/digimon_remote_datasource.dart';
import '../models/digimon_model.dart';
import 'digimon_repository.dart';

class DigimonRepositoryImpl implements DigimonRepository {
  final DigimonRemoteDataSource remoteDataSource;

  DigimonRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<DigimonModel>> getAllDigimon() {
    return remoteDataSource.fetchAllDigimon();
  }

  @override
  Future<List<DigimonModel>> getDigimonByName(String name) {
    return remoteDataSource.fetchDigimonByName(name);
  }

  @override
  Future<List<DigimonModel>> getDigimonByLevel(String level) {
    return remoteDataSource.fetchDigimonByLevel(level);
  }
}
