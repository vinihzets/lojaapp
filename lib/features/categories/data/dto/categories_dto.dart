import '../../domain/entities/categories_entity.dart';

class CategoriesDto extends CategoriesEntity {
  CategoriesDto(super.name, super.imageCategory, super.id);

  factory CategoriesDto.fromJson(Map map) {
    return CategoriesDto(map['name'], map['icon'], map['id']);
  }

  // List<Map>
}
