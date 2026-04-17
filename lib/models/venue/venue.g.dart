// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueNetwork _$VenueNetworkFromJson(Map<String, dynamic> json) => VenueNetwork(
  ownerUserGUID: const UuidValueConverter().fromJson(
    json['owner_user_guid'] as String,
  ),
  name: json['name'] as String,
  description: json['description'] as String,
  verified: json['verified'] as bool,
  logoUrl: json['logo_url'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  venues: (json['venues'] as List<dynamic>)
      .map((e) => Venue.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VenueNetworkToJson(
  VenueNetwork instance,
) => <String, dynamic>{
  'owner_user_guid': const UuidValueConverter().toJson(instance.ownerUserGUID),
  'name': instance.name,
  'description': instance.description,
  'verified': instance.verified,
  'logo_url': instance.logoUrl,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'venues': instance.venues,
};

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
  networkGUID: const UuidValueConverter().fromJson(
    json['network_guid'] as String,
  ),
  networkName: json['network_name'] as String,
  ownerUserGUID: const UuidValueConverter().fromJson(
    json['owner_user_guid'] as String,
  ),
  name: json['name'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  category: json['category'] as String,
  address: json['address'] as String,
  shortAddress: json['short_address'] as String,
  seq: (json['seq'] as num).toInt(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  deliveryRadiusKm: (json['delivery_radius_km'] as num).toDouble(),
  bookingHorizonDay: (json['booking_horizon_day'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  verified: json['verified'] as bool,
  status: json['status'] as String,
  openTime: DateTime.parse(json['open_time'] as String),
  closeTime: DateTime.parse(json['close_time'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  contacts: (json['contacts'] as List<dynamic>)
      .map((e) => VenueContact.fromJson(e as Map<String, dynamic>))
      .toList(),
  worksDay: (json['works_day'] as List<dynamic>)
      .map((e) => VenueSchedule.fromJson(e as Map<String, dynamic>))
      .toList(),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
  'network_guid': const UuidValueConverter().toJson(instance.networkGUID),
  'network_name': instance.networkName,
  'owner_user_guid': const UuidValueConverter().toJson(instance.ownerUserGUID),
  'name': instance.name,
  'tags': instance.tags,
  'description': instance.description,
  'category': instance.category,
  'address': instance.address,
  'short_address': instance.shortAddress,
  'seq': instance.seq,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'delivery_radius_km': instance.deliveryRadiusKm,
  'booking_horizon_day': instance.bookingHorizonDay,
  'rating': instance.rating,
  'verified': instance.verified,
  'status': instance.status,
  'open_time': instance.openTime.toIso8601String(),
  'close_time': instance.closeTime.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'guid': const UuidValueConverter().toJson(instance.guid),
  'contacts': instance.contacts,
  'works_day': instance.worksDay,
  'images': instance.images,
};

VenueContact _$VenueContactFromJson(Map<String, dynamic> json) =>
    VenueContact(type: json['type'] as String, value: json['value'] as String);

Map<String, dynamic> _$VenueContactToJson(VenueContact instance) =>
    <String, dynamic>{'type': instance.type, 'value': instance.value};

VenueSchedule _$VenueScheduleFromJson(Map<String, dynamic> json) =>
    VenueSchedule(
      date: DateTime.parse(json['date'] as String),
      reason: json['reason'] as String?,
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
    );

Map<String, dynamic> _$VenueScheduleToJson(VenueSchedule instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'reason': instance.reason,
      'day_of_week': instance.dayOfWeek,
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
    };

VenueZone _$VenueZoneFromJson(Map<String, dynamic> json) => VenueZone(
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  venueGUID: const UuidValueConverter().fromJson(json['venue_guid'] as String),
  posX: (json['pos_x'] as num).toInt(),
  posY: (json['pos_y'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  name: json['name'] as String,
  type: json['type'] as String,
  tables: (json['tables'] as List<dynamic>)
      .map((e) => Table.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VenueZoneToJson(VenueZone instance) => <String, dynamic>{
  'guid': const UuidValueConverter().toJson(instance.guid),
  'venue_guid': const UuidValueConverter().toJson(instance.venueGUID),
  'pos_x': instance.posX,
  'pos_y': instance.posY,
  'width': instance.width,
  'height': instance.height,
  'name': instance.name,
  'type': instance.type,
  'tables': instance.tables,
};

Table _$TableFromJson(Map<String, dynamic> json) => Table(
  guid: const UuidValueConverter().fromJson(json['guid'] as String),
  zoneGUID: const UuidValueConverter().fromJson(json['zone_guid'] as String),
  name: json['name'] as String,
  seats: (json['seats'] as num).toInt(),
  posX: (json['pos_x'] as num).toInt(),
  posY: (json['pos_y'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  minGuests: (json['min_guests'] as num).toInt(),
  maxGuests: (json['max_guests'] as num).toInt(),
  rotation: (json['rotation'] as num).toDouble(),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$TableToJson(Table instance) => <String, dynamic>{
  'guid': const UuidValueConverter().toJson(instance.guid),
  'zone_guid': const UuidValueConverter().toJson(instance.zoneGUID),
  'name': instance.name,
  'seats': instance.seats,
  'pos_x': instance.posX,
  'pos_y': instance.posY,
  'width': instance.width,
  'height': instance.height,
  'min_guests': instance.minGuests,
  'max_guests': instance.maxGuests,
  'rotation': instance.rotation,
  'is_active': instance.isActive,
};

TableAvailability _$TableAvailabilityFromJson(
  Map<String, dynamic> json,
) => TableAvailability(
  venueGUID: const UuidValueConverter().fromJson(json['venue_guid'] as String),
  tableGUID: const UuidValueConverter().fromJson(json['table_guid'] as String),
  minGuests: (json['min_guests'] as num).toInt(),
  maxGuests: (json['max_guests'] as num).toInt(),
  startTime: DateTime.parse(json['start_time'] as String),
  endTime: DateTime.parse(json['end_time'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TableAvailabilityToJson(TableAvailability instance) =>
    <String, dynamic>{
      'venue_guid': const UuidValueConverter().toJson(instance.venueGUID),
      'table_guid': const UuidValueConverter().toJson(instance.tableGUID),
      'min_guests': instance.minGuests,
      'max_guests': instance.maxGuests,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
