import '../entities/digimon_entity.dart';
import '../../data/repositories/digimon_repository.dart';

class GetAllDigimon {
  final DigimonRepository repository;

  GetAllDigimon(this.repository);

  Future<List<DigimonEntity>> execute() async {
    final models = await repository.getAllDigimon();
    return models
        .map((model) => DigimonEntity(
              name: model.name,
              img: model.img,
              level: model.level,
            ))
        .toList();
  }
}
