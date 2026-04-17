// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuCategory _$MenuCategoryFromJson(Map<String, dynamic> json) => MenuCategory(
  name: json['name'] as String,
  description: json['description'] as String,
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  menuItems: (json['menu_items'] as List<dynamic>)
      .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MenuCategoryToJson(MenuCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'guid': const UuidValueConverter().toJson(instance.guid),
      'menu_items': instance.menuItems,
    };
