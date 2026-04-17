// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
  name: json['name'] as String,
  type: json['type'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['image_url'] as String,
  allergens: (json['allergens'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  calories: (json['calories'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
);

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
  'name': instance.name,
  'type': instance.type,
  'description': instance.description,
  'price': instance.price,
  'image_url': instance.imageUrl,
  'allergens': instance.allergens,
  'calories': instance.calories,
  'discount': instance.discount,
  'guid': const UuidValueConverter().toJson(instance.guid),
};
