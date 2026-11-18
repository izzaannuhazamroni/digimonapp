import '../entities/digimon_entity.dart';
import '../../data/repositories/digimon_repository_impl.dart';

class GetDigimonByName {
  final DigimonRepositoryImpl repository;

  GetDigimonByName(this.repository);

  Future<List<DigimonEntity>> execute(String name) async {
    final models = await repository.getDigimonByName(name);
    return models
        .map((model) => DigimonEntity(
              name: model.name,
              img: model.img,
              level: model.level,
            ))
        .toList();
  }
}
