
import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'menu_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MenuItem {

  final String name;
  final String type;
  final String description;
  final double price;
  final String imageUrl;
  final List<String>? allergens;
  final int calories;
  final int discount;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  MenuItem({
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.allergens,
    required this.calories,
    required this.discount,
    required this.guid
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
  Map<String, dynamic> toJson () => _$MenuItemToJson(this);
}