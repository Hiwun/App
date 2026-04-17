import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';


part 'property.g.dart';


// ====================== В самом верху файла property.dart ======================
const Object _sentinel = Object();   // ← sentinel

@JsonSerializable(fieldRename: FieldRename.snake)
class Property {


  final String title;
  final String type;
  final String actionType;
  final String status;

  final String addressCountry;
  final String addressCity;
  final String addressStreet;
  final String addressHouseNumber;
  final String addressApartmentNumber;
  final double? latitude;
  final double? longitude;

  final double areaTotal;
  final double areaLiving;
  final double areaKitchen;
  final int floorCurrent;
  final int floorTotal;
  final int roomsTotal;
  final int bedroomsTotal;


  final String realtyType;
  final String divisionPossible;
  final List<String> floors;
  final List<String> communication;
  final String entrance;
  final String separatedEntrance;
  final String heating;
  final String unloadingAvailability;
  final String objectStatus;
  final String parkingAvailability;
  final String lineOfPlacement;
  final String exclusive;
  final String whoPaysCommunalService;
  final List<String> intendedPurpose;
  final double powerElectricity;
  final double ceilingHeight;

  final String objectWithTenants;
  final String landCategory;
  final double rentalFlow;
  final double cadastralObjectCost;
  final double cadastralLandCost;
  final double communalCost;
  final double payback;

  final String rentalHolidays;
  final double indexation;
  final String indexationType;

  final double price;
  final double priceForSquareMeter;
  final String currency;
  final double commission;

  final String description;
  @UuidValueConverter()
  @JsonKey(name: 'other_photo_guids')
  final List<UuidValue>  otherPhotoGUIDs;
  @NullableUuidValueConverter()
  @JsonKey(name: 'preview_photo_guid')
  final UuidValue? previewPhotoGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'entrance_photo_guid')
  final UuidValue? entrancePhotoGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'unloading_photo_guid')
  final UuidValue? unloadingPhotoGUID;
  @UuidValueConverter()
  @JsonKey(name: 'external_photo_guids')
  final List<UuidValue>  externalPhotoGUIDs;
  @UuidValueConverter()
  @JsonKey(name: 'internal_photo_guids')
  final List<UuidValue>  internalPhotoGUIDs;
  @NullableUuidValueConverter()
  @JsonKey(name: 'location_photo_guid')
  final UuidValue? locationPhotoGUID;
  @UuidValueConverter()
  @JsonKey(name: 'plan_photo_guids')
  final List<UuidValue> planPhotoGUIDs;

  @UuidValueConverter()
  @JsonKey(name: 'documents_guids')
  final List<UuidValue> documentsGUIDs;
  @NullableUuidValueConverter()
  @JsonKey(name: 'EGRN_guid')
  final UuidValue? EGRNGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'agency_contract_guid')
  final UuidValue? agencyContractGUID;

  final List<FileModel> otherPhoto;
  final FileModel? previewPhoto;
  final FileModel? entrancePhoto;
  final FileModel? unloadingPhoto;
  final List<FileModel> externalPhoto;
  final List<FileModel> internalPhoto;
  final FileModel? locationPhoto;
  final List<FileModel> planPhoto;

  final List<FileModel> documents;
  final FileModel? EGRN;
  final FileModel? agencyContract;

  @NullableUuidValueConverter()
  @JsonKey(name: 'owner_contact_guid')
  final UuidValue? ownerContactGUID;

  @UtcDateTimeConverter()
  final DateTime createdAt;
  @UtcDateTimeConverter()
  final DateTime updatedAt;
  @NullableUtcDateTimeConverter()
  final DateTime? deletedAt;
  @UuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue userGUID;
  @NullableUuidValueConverter()
  @JsonKey(name: 'company_guid')
  final UuidValue? companyGUID;

  @UuidValueConverter()
  @JsonKey(name: 'guid')
  final UuidValue guid;

  Property({
    required this.guid,
    required this.userGUID,
    this.companyGUID,

    required this.title,
    required this.type,
    required this.actionType,
    required this.status,

    required this.addressCountry,
    required this.addressCity,
    required this.addressStreet,
    required this.addressHouseNumber,
    required this.addressApartmentNumber,
    this.latitude,
    this.longitude,

    required this.areaTotal,
    required this.areaLiving,
    required this.areaKitchen,
    required this.floorCurrent,
    required this.floorTotal,
    required this.roomsTotal,
    required this.bedroomsTotal,

    required this.realtyType,
    required this.divisionPossible,
    required this.floors,
    required this.communication,
    required this.entrance,
    required this.separatedEntrance,
    required this.heating,
    required this.unloadingAvailability,
    required this.objectStatus,
    required this.parkingAvailability,
    required this.lineOfPlacement,
    required this.exclusive,
    required this.whoPaysCommunalService,
    required this.intendedPurpose,
    required this.powerElectricity,
    required this.ceilingHeight,

    required this.objectWithTenants,
    required this.landCategory,
    required this.rentalFlow,
    required this.cadastralObjectCost,
    required this.cadastralLandCost,
    required this.communalCost,
    required this.payback,

    required this.rentalHolidays,
    required this.indexation,
    required this.indexationType,

    required this.price,
    required this.priceForSquareMeter,
    required this.currency,
    required this.commission,

    required this.description,
    required this.otherPhotoGUIDs,
    this.previewPhotoGUID,
    this.entrancePhotoGUID,
    this.unloadingPhotoGUID,
    required this.externalPhotoGUIDs,
    required this.internalPhotoGUIDs,
    this.locationPhotoGUID,
    required this.planPhotoGUIDs,

    required this.documentsGUIDs,
    this.EGRNGUID,
    this.agencyContractGUID,

    required this.otherPhoto,
    this.previewPhoto,
    this.entrancePhoto,
    this.unloadingPhoto,
    required this.externalPhoto,
    required this.internalPhoto,
    this.locationPhoto,
    required this.planPhoto,

    required this.documents,
    this.EGRN,
    this.agencyContract,

    this.ownerContactGUID,

    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Property.create({
    required UuidValue userGuid,
    UuidValue? companyGuid,
  }) {
    return Property(
      title: 'Новый объект',
      type: 'Commercial',
      actionType: 'Rent',
      status: 'Draft',
      addressCountry: '',
      addressCity: '',
      addressStreet: '',
      addressHouseNumber: '',
      addressApartmentNumber: '',
      latitude: null,
      longitude: null,
      areaTotal: 0.0,
      areaLiving: 0.0,
      areaKitchen: 0.0,
      floorCurrent: 0,
      floorTotal: 0,
      roomsTotal: 0,
      bedroomsTotal: 0,
      realtyType: '',
      divisionPossible: '',
      floors: [],
      communication: [],
      entrance: '',
      separatedEntrance: '',
      heating: '',
      unloadingAvailability: '',
      objectStatus: '',
      parkingAvailability: '',
      lineOfPlacement: '',
      exclusive: '',
      whoPaysCommunalService: '',
      intendedPurpose: [],
      powerElectricity: 0.0,
      ceilingHeight: 0.0,
      objectWithTenants: '',
      landCategory: '',
      rentalFlow: 0.0,
      cadastralObjectCost: 0.0,
      cadastralLandCost: 0.0,
      communalCost: 0.0,
      payback: 0.0,
      rentalHolidays: '',
      indexation: 0.0,
      indexationType: '',
      price: 0.0,
      priceForSquareMeter: 0.0,
      currency: '',
      commission: 0.0,
      description: '',
      otherPhotoGUIDs: [],
      previewPhotoGUID: null,
      entrancePhotoGUID: null,
      unloadingPhotoGUID: null,
      externalPhotoGUIDs: [],
      internalPhotoGUIDs: [],
      locationPhotoGUID: null,
      planPhotoGUIDs: [],
      documentsGUIDs: [],
      EGRNGUID: null,
      agencyContractGUID: null,
      otherPhoto: [],
      previewPhoto: null,
      entrancePhoto: null,
      unloadingPhoto: null,
      externalPhoto: [],
      internalPhoto: [],
      locationPhoto: null,
      planPhoto: [],
      documents: [],
      EGRN: null,
      agencyContract: null,
      ownerContactGUID: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
      userGUID: userGuid,
      companyGUID: companyGuid,
      guid: Uuid().v4obj(), // Генерация нового GUID
    );
  }
  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);
  Map<String, dynamic> toJson () => _$PropertyToJson(this);

  List<String> getImageUrls () {
    return [
      if (previewPhotoGUID != null)
        FileHelper.getFileUrl(previewPhotoGUID!),
      if (entrancePhotoGUID != null)
        FileHelper.getFileUrl(entrancePhotoGUID!),
      if (unloadingPhotoGUID != null)
        FileHelper.getFileUrl(unloadingPhotoGUID!),
      if (locationPhotoGUID != null)
        FileHelper.getFileUrl(locationPhotoGUID!),
      ...planPhoto.map((elem) => FileHelper.getFileUrl(elem.guid)),
      ...externalPhoto.map((elem) => FileHelper.getFileUrl(elem.guid)),
      ...internalPhoto.map((elem) => FileHelper.getFileUrl(elem.guid)),
      ...otherPhoto.map((elem) => FileHelper.getFileUrl(elem.guid))
    ];
  }

  Property copyWith({
    String? title,
    String? type,
    String? actionType,
    String? status,

    String? addressCountry,
    String? addressCity,
    String? addressStreet,
    String? addressHouseNumber,
    String? addressApartmentNumber,
    double? latitude,
    double? longitude,

    double? areaTotal,
    double? areaLiving,
    double? areaKitchen,
    int? floorCurrent,
    int? floorTotal,
    int? roomsTotal,
    int? bedroomsTotal,

    String? realtyType,
    String? divisionPossible,
    List<String>? floors,
    List<String>? communication,
    String? entrance,
    String? separatedEntrance,
    String? heating,
    String? unloadingAvailability,
    String? objectStatus,
    String? parkingAvailability,
    String? lineOfPlacement,
    String? exclusive,
    String? whoPaysCommunalService,
    List<String>? intendedPurpose,
    double? powerElectricity,
    double? ceilingHeight,

    String? objectWithTenants,
    String? landCategory,
    double? rentalFlow,
    double? cadastralObjectCost,
    double? cadastralLandCost,
    double? communalCost,
    double? payback,

    String? rentalHolidays,
    double? indexation,
    String? indexationType,

    double? price,
    double? priceForSquareMeter,
    String? currency,
    double? commission,

    String? description,

    // ==================== GUID-поля ====================
    List<UuidValue>? otherPhotoGUIDs,
    Object? previewPhotoGUID = _sentinel,
    Object? entrancePhotoGUID = _sentinel,
    Object? unloadingPhotoGUID = _sentinel,
    List<UuidValue>? externalPhotoGUIDs,
    List<UuidValue>? internalPhotoGUIDs,
    Object? locationPhotoGUID = _sentinel,
    List<UuidValue>? planPhotoGUIDs,

    List<UuidValue>? documentsGUIDs,
    Object? EGRNGUID = _sentinel,
    Object? agencyContractGUID = _sentinel,

    // ==================== FileModel-поля ====================
    List<FileModel>? otherPhoto,
    Object? previewPhoto = _sentinel,
    Object? entrancePhoto = _sentinel,
    Object? unloadingPhoto = _sentinel,
    List<FileModel>? externalPhoto,
    List<FileModel>? internalPhoto,
    Object? locationPhoto = _sentinel,
    List<FileModel>? planPhoto,

    List<FileModel>? documents,
    Object? EGRN = _sentinel,
    Object? agencyContract = _sentinel,

    Object? ownerContactGUID = _sentinel,

    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _sentinel,

    UuidValue? userGUID,
    Object? companyGUID = _sentinel,
    UuidValue? guid,
  }) {
    return Property(
      title: title ?? this.title,
      type: type ?? this.type,
      actionType: actionType ?? this.actionType,
      status: status ?? this.status,

      addressCountry: addressCountry ?? this.addressCountry,
      addressCity: addressCity ?? this.addressCity,
      addressStreet: addressStreet ?? this.addressStreet,
      addressHouseNumber: addressHouseNumber ?? this.addressHouseNumber,
      addressApartmentNumber: addressApartmentNumber ?? this.addressApartmentNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,

      areaTotal: areaTotal ?? this.areaTotal,
      areaLiving: areaLiving ?? this.areaLiving,
      areaKitchen: areaKitchen ?? this.areaKitchen,
      floorCurrent: floorCurrent ?? this.floorCurrent,
      floorTotal: floorTotal ?? this.floorTotal,
      roomsTotal: roomsTotal ?? this.roomsTotal,
      bedroomsTotal: bedroomsTotal ?? this.bedroomsTotal,

      realtyType: realtyType ?? this.realtyType,
      divisionPossible: divisionPossible ?? this.divisionPossible,
      floors: floors ?? this.floors,
      communication: communication ?? this.communication,
      entrance: entrance ?? this.entrance,
      separatedEntrance: separatedEntrance ?? this.separatedEntrance,
      heating: heating ?? this.heating,
      unloadingAvailability: unloadingAvailability ?? this.unloadingAvailability,
      objectStatus: objectStatus ?? this.objectStatus,
      parkingAvailability: parkingAvailability ?? this.parkingAvailability,
      lineOfPlacement: lineOfPlacement ?? this.lineOfPlacement,
      exclusive: exclusive ?? this.exclusive,
      whoPaysCommunalService: whoPaysCommunalService ?? this.whoPaysCommunalService,
      intendedPurpose: intendedPurpose ?? this.intendedPurpose,
      powerElectricity: powerElectricity ?? this.powerElectricity,
      ceilingHeight: ceilingHeight ?? this.ceilingHeight,

      objectWithTenants: objectWithTenants ?? this.objectWithTenants,
      landCategory: landCategory ?? this.landCategory,
      rentalFlow: rentalFlow ?? this.rentalFlow,
      cadastralObjectCost: cadastralObjectCost ?? this.cadastralObjectCost,
      cadastralLandCost: cadastralLandCost ?? this.cadastralLandCost,
      communalCost: communalCost ?? this.communalCost,
      payback: payback ?? this.payback,

      rentalHolidays: rentalHolidays ?? this.rentalHolidays,
      indexation: indexation ?? this.indexation,
      indexationType: indexationType ?? this.indexationType,

      price: price ?? this.price,
      priceForSquareMeter: priceForSquareMeter ?? this.priceForSquareMeter,
      currency: currency ?? this.currency,
      commission: commission ?? this.commission,

      description: description ?? this.description,

      otherPhotoGUIDs: otherPhotoGUIDs ?? this.otherPhotoGUIDs,
      previewPhotoGUID: previewPhotoGUID == _sentinel
          ? this.previewPhotoGUID
          : previewPhotoGUID as UuidValue?,
      entrancePhotoGUID: entrancePhotoGUID == _sentinel
          ? this.entrancePhotoGUID
          : entrancePhotoGUID as UuidValue?,
      unloadingPhotoGUID: unloadingPhotoGUID == _sentinel
          ? this.unloadingPhotoGUID
          : unloadingPhotoGUID as UuidValue?,
      externalPhotoGUIDs: externalPhotoGUIDs ?? this.externalPhotoGUIDs,
      internalPhotoGUIDs: internalPhotoGUIDs ?? this.internalPhotoGUIDs,
      locationPhotoGUID: locationPhotoGUID == _sentinel
          ? this.locationPhotoGUID
          : locationPhotoGUID as UuidValue?,
      planPhotoGUIDs: planPhotoGUIDs ?? this.planPhotoGUIDs,

      documentsGUIDs: documentsGUIDs ?? this.documentsGUIDs,
      EGRNGUID: EGRNGUID == _sentinel ? this.EGRNGUID : EGRNGUID as UuidValue?,
      agencyContractGUID: agencyContractGUID == _sentinel
          ? this.agencyContractGUID
          : agencyContractGUID as UuidValue?,

      otherPhoto: otherPhoto ?? this.otherPhoto,
      previewPhoto: previewPhoto == _sentinel ? this.previewPhoto : previewPhoto as FileModel?,
      entrancePhoto: entrancePhoto == _sentinel ? this.entrancePhoto : entrancePhoto as FileModel?,
      unloadingPhoto: unloadingPhoto == _sentinel ? this.unloadingPhoto : unloadingPhoto as FileModel?,
      externalPhoto: externalPhoto ?? this.externalPhoto,
      internalPhoto: internalPhoto ?? this.internalPhoto,
      locationPhoto: locationPhoto == _sentinel ? this.locationPhoto : locationPhoto as FileModel?,
      planPhoto: planPhoto ?? this.planPhoto,

      documents: documents ?? this.documents,
      EGRN: EGRN == _sentinel ? this.EGRN : EGRN as FileModel?,
      agencyContract: agencyContract == _sentinel ? this.agencyContract : agencyContract as FileModel?,

      ownerContactGUID: ownerContactGUID == _sentinel
          ? this.ownerContactGUID
          : ownerContactGUID as UuidValue?,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt == _sentinel ? this.deletedAt : deletedAt as DateTime?,

      userGUID: userGUID ?? this.userGUID,
      companyGUID: companyGUID == _sentinel ? this.companyGUID : companyGUID as UuidValue?,
      guid: guid ?? this.guid,
    );
  }
}