
import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid_value.dart';

part 'venue.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake)
class VenueNetwork{
  @UuidValueConverter()
  @JsonKey(name: 'owner_user_guid')
  final UuidValue ownerUserGUID;

  final String name;
  final String description;
  final bool verified;
  final String logoUrl;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<Venue> venues;

  VenueNetwork({
    required this.ownerUserGUID,
    required this.name,
    required this.description,
    required this.verified,
    required this.logoUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.guid,
    required this.venues
  });


  factory VenueNetwork.fromJson(Map<String, dynamic> json) => _$VenueNetworkFromJson(json);
  Map<String, dynamic> toJson () => _$VenueNetworkToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Venue {
  @UuidValueConverter()
  @JsonKey(name: 'network_guid')
  final UuidValue networkGUID;
  final String networkName;
  @UuidValueConverter()
  @JsonKey(name: 'owner_user_guid')
  final UuidValue ownerUserGUID;
  final String name;
  final List<String> tags;
  final String description;
  final String category;
  final String address;
  final String shortAddress;
  final int seq;
  final double? latitude;
  final double? longitude;
  final double deliveryRadiusKm;
  final int bookingHorizonDay;
  final double rating;
  final bool verified;
  final String status;

  final DateTime openTime;
  final DateTime closeTime;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  final List<VenueContact> contacts;
  final List<VenueSchedule> worksDay;
  final List<String> images;

  Venue({
    required this.networkGUID,
    required this.networkName,
    required this.ownerUserGUID,
    required this.name,
    required this.tags,
    required this.description,
    required this.category,
    required this.address,
    required this.shortAddress,
    required this.seq,
    this.latitude,
    this.longitude,
    required this.deliveryRadiusKm,
    required this.bookingHorizonDay,
    required this.rating,
    required this.verified,
    required this.status,
    required this.openTime,
    required this.closeTime,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.guid,
    required this.contacts,
    required this.worksDay,
    required this.images
  });

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson () => _$VenueToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VenueContact{
  final String type;
  final String value;

  VenueContact({required this.type, required this.value});


  factory VenueContact.fromJson(Map<String, dynamic> json) => _$VenueContactFromJson(json);
  Map<String, dynamic> toJson () => _$VenueContactToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VenueSchedule{
  final DateTime date;
  final String? reason;

  final int dayOfWeek;
  final String openTime;
  final String closeTime;

  VenueSchedule({
    required this.date,
    this.reason,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime
  });

  factory VenueSchedule.fromJson(Map<String, dynamic> json) => _$VenueScheduleFromJson(json);
  Map<String, dynamic> toJson () => _$VenueScheduleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VenueZone{
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  @UuidValueConverter()
  @JsonKey(name: 'venue_guid')
  final UuidValue venueGUID;
  final int posX;
  final int posY;
  final int width;
  final int height;
  final String name;
  final String type;

  final List<Table> tables;

  VenueZone({
    required this.guid,
    required this.venueGUID,
    required this.posX,
    required this.posY,
    required this.width,
    required this.height,
    required this.name,
    required this.type,
    required this.tables
  });

  factory VenueZone.fromJson(Map<String, dynamic> json) => _$VenueZoneFromJson(json);
  Map<String, dynamic> toJson () => _$VenueZoneToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Table{
  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;
  @UuidValueConverter()
  @JsonKey(name: 'zone_guid')
  final UuidValue zoneGUID;

  final String name;
  final int seats;
  final int posX;
  final int posY;
  final int width;
  final int height;
  final int minGuests;
  final int maxGuests;
  final double rotation;
  final bool isActive;

  Table({
    required this.guid,
    required this.zoneGUID,
    required this.name,
    required this.seats,
    required this.posX,
    required this.posY,
    required this.width,
    required this.height,
    required this.minGuests,
    required this.maxGuests,
    required this.rotation,
    required this.isActive
  });

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);
  Map<String, dynamic> toJson () => _$TableToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TableAvailability{

  @UuidValueConverter()
  @JsonKey(name: 'venue_guid')
  final UuidValue venueGUID;
  @UuidValueConverter()
  @JsonKey(name: 'table_guid')
  final UuidValue tableGUID;
  final int minGuests;
  final int maxGuests;

  final DateTime startTime;
  final DateTime endTime;
  final DateTime updatedAt;

  TableAvailability({required this.venueGUID, required this.tableGUID, required this.minGuests, required this.maxGuests, required this.startTime, required this.endTime, required this.updatedAt});

  factory TableAvailability.fromJson(Map<String, dynamic> json) => _$TableAvailabilityFromJson(json);
  Map<String, dynamic> toJson () => _$TableAvailabilityToJson(this);
}