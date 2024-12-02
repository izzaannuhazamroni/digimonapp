import '../entities/digimon_entity.dart';
import '../../data/repositories/digimon_repository.dart';

class GetDigimonByLevel {
  final DigimonRepository repository;

  GetDigimonByLevel(this.repository);

  Future<List<DigimonEntity>> execute(String level) async {
    final models = await repository.getDigimonByLevel(level);
    return models
        .map((model) => DigimonEntity(
              name: model.name,
              img: model.img,
              level: model.level,
            ))
        .toList();
  }
}
