import 'package:lojaapp/features/categories/domain/entities/categories_entity.dart';

class CategoriesDto extends CategoriesEntity {
  CategoriesDto(super.name, super.imageCategory);

  factory CategoriesDto.fromJson(Map map) {
    return CategoriesDto(map['name'], map['icon']);
  }

  // List<Map>
}
