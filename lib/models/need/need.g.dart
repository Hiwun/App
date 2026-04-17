// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'need.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Need _$NeedFromJson(Map<String, dynamic> json) => Need(
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  companyGUID: const NullableUuidValueConverter().fromJson(
    json['company_guid'] as String?,
  ),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  contactGUID: const UuidValueConverter().fromJson(
    json['contact_guid'] as String,
  ),
  propertyGUID: const UuidValueConverter().fromJson(
    json['property_guid'] as String,
  ),
  title: json['title'] as String,
  status: json['status'] as String,
  type: json['type'] as String,
  propertyType: json['property_type'] as String,
  areaMin: (json['area_min'] as num).toDouble(),
  areaMax: (json['area_max'] as num).toDouble(),
  roomsMin: (json['rooms_min'] as num).toInt(),
  roomsMax: (json['rooms_max'] as num).toInt(),
  locationDistricts: (json['location_districts'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  locationMetro: (json['location_metro'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  addressCountry: json['address_country'] as String,
  addressCity: json['address_city'] as String,
  addressStreet: json['address_street'] as String,
  addressHouseNumber: json['address_house_number'] as String,
  addressApartmentNumber: json['address_apartment_number'] as String,
  longitude: (json['longitude'] as num?)?.toDouble(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  radius: (json['radius'] as num?)?.toDouble(),
  squareFrom: (json['square_from'] as num).toDouble(),
  squareTo: (json['square_to'] as num).toDouble(),
  ceilingFrom: (json['ceiling_from'] as num).toDouble(),
  ceilingTo: (json['ceiling_to'] as num).toDouble(),
  powerFrom: (json['power_from'] as num).toDouble(),
  powerTo: (json['power_to'] as num).toDouble(),
  intendedPurpose: (json['intended_purpose'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  realtyType: (json['realty_type'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  floorObject: (json['floor_object'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  communication: (json['communication'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  entrance: (json['entrance'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  separateEntrance: json['separate_entrance'] as String,
  divisionPossible: json['division_possible'] as String,
  objectStatus: (json['object_status'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  heating: (json['heating'] as List<dynamic>).map((e) => e as String).toList(),
  parkingAvailability: json['parking_availability'] as String,
  unloadingAvailability: json['unloading_availability'] as String,
  priceFrom: (json['price_from'] as num).toDouble(),
  priceTo: (json['price_to'] as num).toDouble(),
  priceForSquareMeterFrom: (json['price_for_square_meter_from'] as num)
      .toDouble(),
  priceForSquareMeterTo: (json['price_for_square_meter_to'] as num).toDouble(),
  priceCurrency: json['price_currency'] as String,
  communalCostsFrom: (json['communal_costs_from'] as num).toDouble(),
  communalCostsTo: (json['communal_costs_to'] as num).toDouble(),
  whoPaysCommunal: (json['who_pays_communal'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  lineOfPlacement: (json['line_of_placement'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  networkRequest: json['network_request'] as String,
  holidaysRequirement: json['holidays_requirement'] as String,
  indexation: (json['indexation'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  paybackFrom: (json['payback_from'] as num).toDouble(),
  paybackTo: (json['payback_to'] as num).toDouble(),
  rentalFlowTo: (json['rental_flow_to'] as num).toDouble(),
  rentalFlowFrom: (json['rental_flow_from'] as num).toDouble(),
  landCategory: (json['land_category'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  objectWithTenants: json['object_with_tenants'] as String,
  urgency: json['urgency'] as String,
  notes: json['notes'] as String,
  createdAt: const UtcDateTimeConverter().fromJson(
    json['created_at'] as String,
  ),
  updatedAt: const UtcDateTimeConverter().fromJson(
    json['updated_at'] as String,
  ),
  deletedAt: const NullableUtcDateTimeConverter().fromJson(
    json['deleted_at'] as String?,
  ),
);

Map<String, dynamic> _$NeedToJson(Need instance) => <String, dynamic>{
  'title': instance.title,
  'status': instance.status,
  'type': instance.type,
  'property_type': instance.propertyType,
  'area_min': instance.areaMin,
  'area_max': instance.areaMax,
  'rooms_min': instance.roomsMin,
  'rooms_max': instance.roomsMax,
  'location_districts': instance.locationDistricts,
  'location_metro': instance.locationMetro,
  'address_country': instance.addressCountry,
  'address_city': instance.addressCity,
  'address_street': instance.addressStreet,
  'address_house_number': instance.addressHouseNumber,
  'address_apartment_number': instance.addressApartmentNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'radius': instance.radius,
  'square_from': instance.squareFrom,
  'square_to': instance.squareTo,
  'ceiling_from': instance.ceilingFrom,
  'ceiling_to': instance.ceilingTo,
  'power_from': instance.powerFrom,
  'power_to': instance.powerTo,
  'intended_purpose': instance.intendedPurpose,
  'realty_type': instance.realtyType,
  'floor_object': instance.floorObject,
  'communication': instance.communication,
  'entrance': instance.entrance,
  'separate_entrance': instance.separateEntrance,
  'division_possible': instance.divisionPossible,
  'object_status': instance.objectStatus,
  'heating': instance.heating,
  'parking_availability': instance.parkingAvailability,
  'unloading_availability': instance.unloadingAvailability,
  'price_from': instance.priceFrom,
  'price_to': instance.priceTo,
  'price_for_square_meter_from': instance.priceForSquareMeterFrom,
  'price_for_square_meter_to': instance.priceForSquareMeterTo,
  'price_currency': instance.priceCurrency,
  'communal_costs_from': instance.communalCostsFrom,
  'communal_costs_to': instance.communalCostsTo,
  'who_pays_communal': instance.whoPaysCommunal,
  'line_of_placement': instance.lineOfPlacement,
  'network_request': instance.networkRequest,
  'holidays_requirement': instance.holidaysRequirement,
  'indexation': instance.indexation,
  'payback_from': instance.paybackFrom,
  'payback_to': instance.paybackTo,
  'rental_flow_from': instance.rentalFlowFrom,
  'rental_flow_to': instance.rentalFlowTo,
  'land_category': instance.landCategory,
  'object_with_tenants': instance.objectWithTenants,
  'urgency': instance.urgency,
  'notes': instance.notes,
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'property_guid': const UuidValueConverter().toJson(instance.propertyGUID),
  'contact_guid': const UuidValueConverter().toJson(instance.contactGUID),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'company_guid': const NullableUuidValueConverter().toJson(
    instance.companyGUID,
  ),
  'guid': const UuidValueConverter().toJson(instance.guid),
};
