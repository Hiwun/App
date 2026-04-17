import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'menu_category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MenuCategory {

  final String name;
  final String description;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<MenuItem> menuItems;

  MenuCategory({
    required this.name,
    required this.description,
    required this.guid,
    required this.menuItems
  });


  factory MenuCategory.fromJson(Map<String, dynamic> json) => _$MenuCategoryFromJson(json);
  Map<String, dynamic> toJson () => _$MenuCategoryToJson(this);
}