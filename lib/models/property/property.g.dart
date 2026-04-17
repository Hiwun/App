// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  userGUID: const UuidValueConverter().fromJson(json['user_guid'] as String),
  companyGUID: const NullableUuidValueConverter().fromJson(
    json['company_guid'] as String?,
  ),
  title: json['title'] as String,
  type: json['type'] as String,
  actionType: json['action_type'] as String,
  status: json['status'] as String,
  addressCountry: json['address_country'] as String,
  addressCity: json['address_city'] as String,
  addressStreet: json['address_street'] as String,
  addressHouseNumber: json['address_house_number'] as String,
  addressApartmentNumber: json['address_apartment_number'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  areaTotal: (json['area_total'] as num).toDouble(),
  areaLiving: (json['area_living'] as num).toDouble(),
  areaKitchen: (json['area_kitchen'] as num).toDouble(),
  floorCurrent: (json['floor_current'] as num).toInt(),
  floorTotal: (json['floor_total'] as num).toInt(),
  roomsTotal: (json['rooms_total'] as num).toInt(),
  bedroomsTotal: (json['bedrooms_total'] as num).toInt(),
  realtyType: json['realty_type'] as String,
  divisionPossible: json['division_possible'] as String,
  floors: (json['floors'] as List<dynamic>).map((e) => e as String).toList(),
  communication: (json['communication'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  entrance: json['entrance'] as String,
  separatedEntrance: json['separated_entrance'] as String,
  heating: json['heating'] as String,
  unloadingAvailability: json['unloading_availability'] as String,
  objectStatus: json['object_status'] as String,
  parkingAvailability: json['parking_availability'] as String,
  lineOfPlacement: json['line_of_placement'] as String,
  exclusive: json['exclusive'] as String,
  whoPaysCommunalService: json['who_pays_communal_service'] as String,
  intendedPurpose: (json['intended_purpose'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  powerElectricity: (json['power_electricity'] as num).toDouble(),
  ceilingHeight: (json['ceiling_height'] as num).toDouble(),
  objectWithTenants: json['object_with_tenants'] as String,
  landCategory: json['land_category'] as String,
  rentalFlow: (json['rental_flow'] as num).toDouble(),
  cadastralObjectCost: (json['cadastral_object_cost'] as num).toDouble(),
  cadastralLandCost: (json['cadastral_land_cost'] as num).toDouble(),
  communalCost: (json['communal_cost'] as num).toDouble(),
  payback: (json['payback'] as num).toDouble(),
  rentalHolidays: json['rental_holidays'] as String,
  indexation: (json['indexation'] as num).toDouble(),
  indexationType: json['indexation_type'] as String,
  price: (json['price'] as num).toDouble(),
  priceForSquareMeter: (json['price_for_square_meter'] as num).toDouble(),
  currency: json['currency'] as String,
  commission: (json['commission'] as num).toDouble(),
  description: json['description'] as String,
  otherPhotoGUIDs: (json['other_photo_guids'] as List<dynamic>)
      .map((e) => const UuidValueConverter().fromJson(e as String))
      .toList(),
  previewPhotoGUID: const NullableUuidValueConverter().fromJson(
    json['preview_photo_guid'] as String?,
  ),
  entrancePhotoGUID: const NullableUuidValueConverter().fromJson(
    json['entrance_photo_guid'] as String?,
  ),
  unloadingPhotoGUID: const NullableUuidValueConverter().fromJson(
    json['unloading_photo_guid'] as String?,
  ),
  externalPhotoGUIDs: (json['external_photo_guids'] as List<dynamic>)
      .map((e) => const UuidValueConverter().fromJson(e as String))
      .toList(),
  internalPhotoGUIDs: (json['internal_photo_guids'] as List<dynamic>)
      .map((e) => const UuidValueConverter().fromJson(e as String))
      .toList(),
  locationPhotoGUID: const NullableUuidValueConverter().fromJson(
    json['location_photo_guid'] as String?,
  ),
  planPhotoGUIDs: (json['plan_photo_guids'] as List<dynamic>)
      .map((e) => const UuidValueConverter().fromJson(e as String))
      .toList(),
  documentsGUIDs: (json['documents_guids'] as List<dynamic>)
      .map((e) => const UuidValueConverter().fromJson(e as String))
      .toList(),
  EGRNGUID: const NullableUuidValueConverter().fromJson(
    json['EGRN_guid'] as String?,
  ),
  agencyContractGUID: const NullableUuidValueConverter().fromJson(
    json['agency_contract_guid'] as String?,
  ),
  otherPhoto: (json['other_photo'] as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  previewPhoto: json['preview_photo'] == null
      ? null
      : FileModel.fromJson(json['preview_photo'] as Map<String, dynamic>),
  entrancePhoto: json['entrance_photo'] == null
      ? null
      : FileModel.fromJson(json['entrance_photo'] as Map<String, dynamic>),
  unloadingPhoto: json['unloading_photo'] == null
      ? null
      : FileModel.fromJson(json['unloading_photo'] as Map<String, dynamic>),
  externalPhoto: (json['external_photo'] as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  internalPhoto: (json['internal_photo'] as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  locationPhoto: json['location_photo'] == null
      ? null
      : FileModel.fromJson(json['location_photo'] as Map<String, dynamic>),
  planPhoto: (json['plan_photo'] as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  documents: (json['documents'] as List<dynamic>)
      .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  EGRN: json['e_g_r_n'] == null
      ? null
      : FileModel.fromJson(json['e_g_r_n'] as Map<String, dynamic>),
  agencyContract: json['agency_contract'] == null
      ? null
      : FileModel.fromJson(json['agency_contract'] as Map<String, dynamic>),
  ownerContactGUID: const NullableUuidValueConverter().fromJson(
    json['owner_contact_guid'] as String?,
  ),
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

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
  'title': instance.title,
  'type': instance.type,
  'action_type': instance.actionType,
  'status': instance.status,
  'address_country': instance.addressCountry,
  'address_city': instance.addressCity,
  'address_street': instance.addressStreet,
  'address_house_number': instance.addressHouseNumber,
  'address_apartment_number': instance.addressApartmentNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'area_total': instance.areaTotal,
  'area_living': instance.areaLiving,
  'area_kitchen': instance.areaKitchen,
  'floor_current': instance.floorCurrent,
  'floor_total': instance.floorTotal,
  'rooms_total': instance.roomsTotal,
  'bedrooms_total': instance.bedroomsTotal,
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
  'who_pays_communal_service': instance.whoPaysCommunalService,
  'intended_purpose': instance.intendedPurpose,
  'power_electricity': instance.powerElectricity,
  'ceiling_height': instance.ceilingHeight,
  'object_with_tenants': instance.objectWithTenants,
  'land_category': instance.landCategory,
  'rental_flow': instance.rentalFlow,
  'cadastral_object_cost': instance.cadastralObjectCost,
  'cadastral_land_cost': instance.cadastralLandCost,
  'communal_cost': instance.communalCost,
  'payback': instance.payback,
  'rental_holidays': instance.rentalHolidays,
  'indexation': instance.indexation,
  'indexation_type': instance.indexationType,
  'price': instance.price,
  'price_for_square_meter': instance.priceForSquareMeter,
  'currency': instance.currency,
  'commission': instance.commission,
  'description': instance.description,
  'other_photo_guids': instance.otherPhotoGUIDs
      .map(const UuidValueConverter().toJson)
      .toList(),
  'preview_photo_guid': const NullableUuidValueConverter().toJson(
    instance.previewPhotoGUID,
  ),
  'entrance_photo_guid': const NullableUuidValueConverter().toJson(
    instance.entrancePhotoGUID,
  ),
  'unloading_photo_guid': const NullableUuidValueConverter().toJson(
    instance.unloadingPhotoGUID,
  ),
  'external_photo_guids': instance.externalPhotoGUIDs
      .map(const UuidValueConverter().toJson)
      .toList(),
  'internal_photo_guids': instance.internalPhotoGUIDs
      .map(const UuidValueConverter().toJson)
      .toList(),
  'location_photo_guid': const NullableUuidValueConverter().toJson(
    instance.locationPhotoGUID,
  ),
  'plan_photo_guids': instance.planPhotoGUIDs
      .map(const UuidValueConverter().toJson)
      .toList(),
  'documents_guids': instance.documentsGUIDs
      .map(const UuidValueConverter().toJson)
      .toList(),
  'EGRN_guid': const NullableUuidValueConverter().toJson(instance.EGRNGUID),
  'agency_contract_guid': const NullableUuidValueConverter().toJson(
    instance.agencyContractGUID,
  ),
  'other_photo': instance.otherPhoto,
  'preview_photo': instance.previewPhoto,
  'entrance_photo': instance.entrancePhoto,
  'unloading_photo': instance.unloadingPhoto,
  'external_photo': instance.externalPhoto,
  'internal_photo': instance.internalPhoto,
  'location_photo': instance.locationPhoto,
  'plan_photo': instance.planPhoto,
  'documents': instance.documents,
  'e_g_r_n': instance.EGRN,
  'agency_contract': instance.agencyContract,
  'owner_contact_guid': const NullableUuidValueConverter().toJson(
    instance.ownerContactGUID,
  ),
  'created_at': const UtcDateTimeConverter().toJson(instance.createdAt),
  'updated_at': const UtcDateTimeConverter().toJson(instance.updatedAt),
  'deleted_at': const NullableUtcDateTimeConverter().toJson(instance.deletedAt),
  'user_guid': const UuidValueConverter().toJson(instance.userGUID),
  'company_guid': const NullableUuidValueConverter().toJson(
    instance.companyGUID,
  ),
  'guid': const UuidValueConverter().toJson(instance.guid),
};
