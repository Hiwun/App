// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyFilter _$PropertyFilterFromJson(
  Map<String, dynamic> json,
) => PropertyFilter(
  userGuid: const NullableUuidValueConverter().fromJson(
    json['user_guid'] as String?,
  ),
  statuses: (json['statuses'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
  actionTypes: (json['action_types'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  country: json['country'] as String,
  city: json['city'] as String,
  street: json['street'] as String,
  houseNumber: json['house_number'] as String,
  radius: (json['radius'] as num?)?.toDouble(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  minAreaTotal: (json['min_area_total'] as num?)?.toDouble(),
  maxAreaTotal: (json['max_area_total'] as num?)?.toDouble(),
  minAreaLiving: (json['min_area_living'] as num?)?.toDouble(),
  maxAreaLiving: (json['max_area_living'] as num?)?.toDouble(),
  minAreaKitchen: (json['min_area_kitchen'] as num?)?.toDouble(),
  maxAreaKitchen: (json['max_area_kitchen'] as num?)?.toDouble(),
  minFloorCurrent: (json['min_floor_current'] as num?)?.toInt(),
  maxFloorCurrent: (json['max_floor_current'] as num?)?.toInt(),
  floorTotal: (json['floor_total'] as num?)?.toInt(),
  minRoomsTotal: (json['min_rooms_total'] as num?)?.toInt(),
  maxRoomsTotal: (json['max_rooms_total'] as num?)?.toInt(),
  minBedrooms: (json['min_bedrooms'] as num?)?.toInt(),
  maxBedrooms: (json['max_bedrooms'] as num?)?.toInt(),
  realtyType: (json['realty_type'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  divisionPossible: (json['division_possible'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  floors: (json['floors'] as List<dynamic>).map((e) => e as String).toList(),
  communication: (json['communication'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  entrance: (json['entrance'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  separatedEntrance: (json['separated_entrance'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  heating: (json['heating'] as List<dynamic>).map((e) => e as String).toList(),
  unloadingAvailability: (json['unloading_availability'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  objectStatus: (json['object_status'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  parkingAvailability: (json['parking_availability'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  lineOfPlacement: (json['line_of_placement'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  exclusive: (json['exclusive'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  whoPaysCommunal: (json['who_pays_communal'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  intendedPurpose: (json['intended_purpose'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minPowerElectricity: (json['min_power_electricity'] as num?)?.toDouble(),
  maxPowerElectricity: (json['max_power_electricity'] as num?)?.toDouble(),
  minCeilingHeight: (json['min_ceiling_height'] as num?)?.toDouble(),
  maxCeilingHeight: (json['max_ceiling_height'] as num?)?.toDouble(),
  objectWithTenants: (json['object_with_tenants'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  landCategory: (json['land_category'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minRentalFlow: (json['min_rental_flow'] as num?)?.toDouble(),
  maxRentalFlow: (json['max_rental_flow'] as num?)?.toDouble(),
  minCadastralObjectCost: (json['min_cadastral_object_cost'] as num?)
      ?.toDouble(),
  maxCadastralObjectCost: (json['max_cadastral_object_cost'] as num?)
      ?.toDouble(),
  minCadastralLandCost: (json['min_cadastral_land_cost'] as num?)?.toDouble(),
  maxCadastralLandCost: (json['max_cadastral_land_cost'] as num?)?.toDouble(),
  minCommunalCost: (json['min_communal_cost'] as num?)?.toDouble(),
  maxCommunalCost: (json['max_communal_cost'] as num?)?.toDouble(),
  minPayback: (json['min_payback'] as num?)?.toDouble(),
  maxPayback: (json['max_payback'] as num?)?.toDouble(),
  rentalHolidays: (json['rental_holidays'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minIndexation: (json['min_indexation'] as num?)?.toDouble(),
  maxIndexation: (json['max_indexation'] as num?)?.toDouble(),
  indexationType: (json['indexation_type'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minPrice: (json['min_price'] as num?)?.toDouble(),
  maxPrice: (json['max_price'] as num?)?.toDouble(),
  minPricePerSquareMeter: (json['min_price_per_square_meter'] as num?)
      ?.toDouble(),
  maxPricePerSquareMeter: (json['max_price_per_square_meter'] as num?)
      ?.toDouble(),
  currencies: (json['currencies'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minCommission: (json['min_commission'] as num?)?.toDouble(),
  maxCommission: (json['max_commission'] as num?)?.toDouble(),
  search: json['search'] as String,
  createdFrom: const NullableUtcDateTimeConverter().fromJson(
    json['created_from'] as String?,
  ),
  createdTo: const NullableUtcDateTimeConverter().fromJson(
    json['created_to'] as String?,
  ),
  updatedFrom: const NullableUtcDateTimeConverter().fromJson(
    json['updated_from'] as String?,
  ),
  updatedTo: const NullableUtcDateTimeConverter().fromJson(
    json['updated_to'] as String?,
  ),
  ownerContactGuid: const NullableUuidValueConverter().fromJson(
    json['owner_contact_guid'] as String?,
  ),
  sortBy: json['sort_by'] as String,
  sortOrder: json['sort_order'] as String,
);

Map<String, dynamic> _$PropertyFilterToJson(
  PropertyFilter instance,
) => <String, dynamic>{
  'user_guid': const NullableUuidValueConverter().toJson(instance.userGuid),
  'statuses': instance.statuses,
  'types': instance.types,
  'action_types': instance.actionTypes,
  'country': instance.country,
  'city': instance.city,
  'street': instance.street,
  'house_number': instance.houseNumber,
  'radius': instance.radius,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'min_area_total': instance.minAreaTotal,
  'max_area_total': instance.maxAreaTotal,
  'min_area_living': instance.minAreaLiving,
  'max_area_living': instance.maxAreaLiving,
  'min_area_kitchen': instance.minAreaKitchen,
  'max_area_kitchen': instance.maxAreaKitchen,
  'min_floor_current': instance.minFloorCurrent,
  'max_floor_current': instance.maxFloorCurrent,
  'floor_total': instance.floorTotal,
  'min_rooms_total': instance.minRoomsTotal,
  'max_rooms_total': instance.maxRoomsTotal,
  'min_bedrooms': instance.minBedrooms,
  'max_bedrooms': instance.maxBedrooms,
  'realty_type': instance.realtyType,
  'division_possible': instance.divisionPossible,
  'floors': instance.floors,
  'communication': instance.communication,
  'entrance': instance.entrance,
  'separated_entrance': instance.separatedEntrance,
  'heating': instance.heating,
  'unloading_availability': instance.unloadingAvailability,
  'object_status': instance.objectStatus,
  'parking_availability': instance.parkingAvailability,
  'line_of_placement': instance.lineOfPlacement,
  'exclusive': instance.exclusive,
  'who_pays_communal': instance.whoPaysCommunal,
  'intended_purpose': instance.intendedPurpose,
  'min_power_electricity': instance.minPowerElectricity,
  'max_power_electricity': instance.maxPowerElectricity,
  'min_ceiling_height': instance.minCeilingHeight,
  'max_ceiling_height': instance.maxCeilingHeight,
  'object_with_tenants': instance.objectWithTenants,
  'land_category': instance.landCategory,
  'min_rental_flow': instance.minRentalFlow,
  'max_rental_flow': instance.maxRentalFlow,
  'min_cadastral_object_cost': instance.minCadastralObjectCost,
  'max_cadastral_object_cost': instance.maxCadastralObjectCost,
  'min_cadastral_land_cost': instance.minCadastralLandCost,
  'max_cadastral_land_cost': instance.maxCadastralLandCost,
  'min_communal_cost': instance.minCommunalCost,
  'max_communal_cost': instance.maxCommunalCost,
  'min_payback': instance.minPayback,
  'max_payback': instance.maxPayback,
  'rental_holidays': instance.rentalHolidays,
  'min_indexation': instance.minIndexation,
  'max_indexation': instance.maxIndexation,
  'indexation_type': instance.indexationType,
  'min_price': instance.minPrice,
  'max_price': instance.maxPrice,
  'min_price_per_square_meter': instance.minPricePerSquareMeter,
  'max_price_per_square_meter': instance.maxPricePerSquareMeter,
  'currencies': instance.currencies,
  'min_commission': instance.minCommission,
  'max_commission': instance.maxCommission,
  'search': instance.search,
  'created_from': const NullableUtcDateTimeConverter().toJson(
    instance.createdFrom,
  ),
  'created_to': const NullableUtcDateTimeConverter().toJson(instance.createdTo),
  'updated_from': const NullableUtcDateTimeConverter().toJson(
    instance.updatedFrom,
  ),
  'updated_to': const NullableUtcDateTimeConverter().toJson(instance.updatedTo),
  'owner_contact_guid': const NullableUuidValueConverter().toJson(
    instance.ownerContactGuid,
  ),
  'sort_by': instance.sortBy,
  'sort_order': instance.sortOrder,
};
