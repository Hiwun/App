import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'need.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Need {

  final String title;
  final String status;
  final String type;

  final String propertyType;
  final double areaMin;
  final double areaMax;
  final int roomsMin;
  final int roomsMax;
  final List<String> locationDistricts;
  final List<String> locationMetro;

  final String addressCountry;
  final String addressCity;
  final String addressStreet;
  final String addressHouseNumber;
  final String addressApartmentNumber;
  final double? latitude;
  final double? longitude;
  final double? radius;

  final double squareFrom;
  final double squareTo;
  final double ceilingFrom;
  final double ceilingTo;
  final double powerFrom;
  final double powerTo;
  final List<String> intendedPurpose;
  final List<String> realtyType;
  final List<String> floorObject;
  final List<String> communication;
  final List<String> entrance;
  final String separateEntrance;
  final String divisionPossible;
  final List<String> objectStatus;
  final List<String> heating;
  final String parkingAvailability;
  final String unloadingAvailability;

  final double priceFrom;
  final double priceTo;
  final double priceForSquareMeterFrom;
  final double priceForSquareMeterTo;
  final String priceCurrency;
  final double communalCostsFrom;
  final double communalCostsTo;
  final List<String> whoPaysCommunal;

  final List<String> lineOfPlacement;

  final String networkRequest;
  final String holidaysRequirement;
  final List<String> indexation;

  final double paybackFrom;
  final double paybackTo;
  final double rentalFlowFrom;
  final double rentalFlowTo;
  final List<String> landCategory;
  final String objectWithTenants;

  final String urgency;
  final String notes;

  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'property_guid')
  final UuidValue propertyGUID;
  @UuidValueConverter()
  @JsonKey(name: 'contact_guid')
  final UuidValue contactGUID;

  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  Need({
    required this.userGUID,
    this.companyGUID,
    required this.guid,
    required this.contactGUID,
    required this.propertyGUID,

    required this.title,
    required this.status,
    required this.type,

    required this.propertyType,
    required this.areaMin,
    required this.areaMax,
    required this.roomsMin,
    required this.roomsMax,
    required this.locationDistricts,
    required this.locationMetro,

    required this.addressCountry,
    required this.addressCity,
    required this.addressStreet,
    required this.addressHouseNumber,
    required this.addressApartmentNumber,
    this.longitude,
    this.latitude,
    this.radius,

    required this.squareFrom,
    required this.squareTo,
    required this.ceilingFrom,
    required this.ceilingTo,
    required this.powerFrom,
    required this.powerTo,
    required this.intendedPurpose,
    required this.realtyType,
    required this.floorObject,
    required this.communication,
    required this.entrance,
    required this.separateEntrance,
    required this.divisionPossible,
    required this.objectStatus,
    required this.heating,
    required this.parkingAvailability,
    required this.unloadingAvailability,

    required this.priceFrom,
    required this.priceTo,
    required this.priceForSquareMeterFrom,
    required this.priceForSquareMeterTo,
    required this.priceCurrency,
    required this.communalCostsFrom,
    required this.communalCostsTo,
    required this.whoPaysCommunal,

    required this.lineOfPlacement,

    required this.networkRequest,
    required this.holidaysRequirement,
    required this.indexation,

    required this.paybackFrom,
    required this.paybackTo,
    required this.rentalFlowTo,
    required this.rentalFlowFrom,
    required this.landCategory,
    required this.objectWithTenants,

    required this.urgency,
    required this.notes,

    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });


  factory Need.fromJson(Map<String, dynamic> json) => _$NeedFromJson(json);
  Map<String, dynamic> toJson () => _$NeedToJson(this);
}