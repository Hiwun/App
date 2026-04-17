import 'package:json_annotation/json_annotation.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

part 'property_filter.g.dart';

// ====================== В самом верху файла property.dart ======================
const Object _sentinel = Object();   // ← sentinel

@JsonSerializable(fieldRename: FieldRename.snake)
class PropertyFilter {
  // Базовые фильтры
  @NullableUuidValueConverter()
  @JsonKey(name: 'user_guid')
  final UuidValue? userGuid; // Фильтр по владельцу записи (брокеру)
  final List<String> statuses; // Active, Inactive, Sold, Rented, Archived
  final List<String> types; // Apartment, House, Commercial, Land
  final List<String> actionTypes; // Rent, Sell

  // Адрес и геолокация
  final String country;
  final String city;
  final String street;
  final String houseNumber;
  final double? radius; // Радиус поиска в км (если есть lat/lng)
  final double? latitude; // Центр поиска по радиусу
  final double? longitude; // Центр поиска по радиусу

  // Основные характеристики (жилая недвижимость)
  final double? minAreaTotal;
  final double? maxAreaTotal;
  final double? minAreaLiving;
  final double? maxAreaLiving;
  final double? minAreaKitchen;
  final double? maxAreaKitchen;
  final int? minFloorCurrent;
  final int? maxFloorCurrent;
  final int? floorTotal; // Точное значение этажности дома
  final int? minRoomsTotal;
  final int? maxRoomsTotal;
  final int? minBedrooms;
  final int? maxBedrooms;

  // Характеристики коммерции
  final List<String> realtyType; // Тип недвижимости (офис, ТЦ, склад и т.д.)
  final List<String> divisionPossible; // Возможно ли деление
  final List<String> floors; // Этажи (помещение на 1,2 этаже и т.д.)
  final List<String> communication; // Коммуникации (вода, газ, электричество)
  final List<String> entrance; // Тип входа
  final List<String> separatedEntrance; // Отдельный вход
  final List<String> heating; // Отопление
  final List<String> unloadingAvailability; // Наличие разгрузки
  final List<String> objectStatus; // Статус ремонта
  final List<String> parkingAvailability; // Парковка
  final List<String> lineOfPlacement; // Линия размещения (1-я, 2-я)
  final List<String> exclusive; // Эксклюзивный контракт
  final List<String> whoPaysCommunal; // Кто платит коммуналку
  final List<String> intendedPurpose; // Целевое назначение
  final double? minPowerElectricity; // Мин. мощность э/с (кВт)
  final double? maxPowerElectricity; // Макс. мощность э/с
  final double? minCeilingHeight; // Мин. высота потолков
  final double? maxCeilingHeight; // Макс. высота потолков

  // Коммерция (покупка)
  final List<String> objectWithTenants; // С арендаторами или без
  final List<String> landCategory; // Категория земли
  final double? minRentalFlow; // Мин. арендный поток
  final double? maxRentalFlow; // Макс. арендный поток
  final double? minCadastralObjectCost;
  final double? maxCadastralObjectCost;
  final double? minCadastralLandCost;
  final double? maxCadastralLandCost;
  final double? minCommunalCost;
  final double? maxCommunalCost;
  final double? minPayback; // Мин. окупаемость (мес/лет)
  final double? maxPayback; // Макс. окупаемость

  // Коммерция (аренда)
  final List<String> rentalHolidays; // Арендные каникулы
  final double? minIndexation; // Мин. индексация (%)
  final double? maxIndexation; // Макс. индексация (%)
  final List<String> indexationType; // Тип индексации

  // Финансы
  final double? minPrice;
  final double? maxPrice;
  final double? minPricePerSquareMeter;
  final double? maxPricePerSquareMeter;
  final List<String> currencies; // RUB, USD, EUR
  final double? minCommission;
  final double? maxCommission;

  // Текстовый поиск
  final String search; // Поиск по названию

  // Временные фильтры
  @NullableUtcDateTimeConverter()
  final DateTime? createdFrom;
  @NullableUtcDateTimeConverter()
  final DateTime? createdTo;
  @NullableUtcDateTimeConverter()
  final DateTime? updatedFrom;
  @NullableUtcDateTimeConverter()
  final DateTime? updatedTo;

  // Связи
  @NullableUuidValueConverter()
  @JsonKey(name: 'owner_contact_guid')
  final UuidValue? ownerContactGuid;

  // Сортировка
  final String sortBy; // price, created_at, area_total, price_per_square_meter
  final String sortOrder; // asc, desc

  PropertyFilter({
    this.userGuid,
    required this.statuses,
    required this.types,
    required this.actionTypes,
    required this.country,
    required this.city,
    required this.street,
    required this.houseNumber,
    this.radius,
    this.latitude,
    this.longitude,
    this.minAreaTotal,
    this.maxAreaTotal,
    this.minAreaLiving,
    this.maxAreaLiving,
    this.minAreaKitchen,
    this.maxAreaKitchen,
    this.minFloorCurrent,
    this.maxFloorCurrent,
    this.floorTotal,
    this.minRoomsTotal,
    this.maxRoomsTotal,
    this.minBedrooms,
    this.maxBedrooms,
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
    required this.whoPaysCommunal,
    required this.intendedPurpose,
    this.minPowerElectricity,
    this.maxPowerElectricity,
    this.minCeilingHeight,
    this.maxCeilingHeight,
    required this.objectWithTenants,
    required this.landCategory,
    this.minRentalFlow,
    this.maxRentalFlow,
    this.minCadastralObjectCost,
    this.maxCadastralObjectCost,
    this.minCadastralLandCost,
    this.maxCadastralLandCost,
    this.minCommunalCost,
    this.maxCommunalCost,
    this.minPayback,
    this.maxPayback,
    required this.rentalHolidays,
    this.minIndexation,
    this.maxIndexation,
    required this.indexationType,
    this.minPrice,
    this.maxPrice,
    this.minPricePerSquareMeter,
    this.maxPricePerSquareMeter,
    required this.currencies,
    this.minCommission,
    this.maxCommission,
    required this.search,
    this.createdFrom,
    this.createdTo,
    this.updatedFrom,
    this.updatedTo,
    this.ownerContactGuid,
    required this.sortBy,
    required this.sortOrder,
  });

  factory PropertyFilter.create() {
    return PropertyFilter(
      sortBy: 'created_at',
      sortOrder: 'desc',
      statuses: [],
      types: [],
      actionTypes: [],
      country: '',
      city: '',
      street: '',
      houseNumber: '',
      realtyType: [],
      divisionPossible: [],
      floors: [],
      communication: [],
      entrance: [],
      separatedEntrance: [],
      heating: [],
      unloadingAvailability: [],
      objectStatus: [],
      parkingAvailability: [],
      lineOfPlacement: [],
      exclusive: [],
      whoPaysCommunal: [],
      intendedPurpose: [],
      objectWithTenants: [],
      landCategory: [],
      rentalHolidays: [],
      indexationType: [],
      currencies: [],
      search: '',
    );
  }

  factory PropertyFilter.fromJson(Map<String, dynamic> json) =>
      _$PropertyFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyFilterToJson(this);

  PropertyFilter copyWith({
    // Базовые фильтры
    Object? userGuid = _sentinel,
    List<String>? statuses,
    List<String>? types,
    List<String>? actionTypes,

    // Адрес и геолокация
    String? country,
    String? city,
    String? street,
    String? houseNumber,
    Object? radius = _sentinel,
    Object? latitude = _sentinel,
    Object? longitude = _sentinel,

    // Основные характеристики
    Object? minAreaTotal = _sentinel,
    Object? maxAreaTotal = _sentinel,
    Object? minAreaLiving = _sentinel,
    Object? maxAreaLiving = _sentinel,
    Object? minAreaKitchen = _sentinel,
    Object? maxAreaKitchen = _sentinel,
    Object? minFloorCurrent = _sentinel,
    Object? maxFloorCurrent = _sentinel,
    Object? floorTotal = _sentinel,
    Object? minRoomsTotal = _sentinel,
    Object? maxRoomsTotal = _sentinel,
    Object? minBedrooms = _sentinel,
    Object? maxBedrooms = _sentinel,

    // Характеристики коммерции
    List<String>? realtyType,
    List<String>? divisionPossible,
    List<String>? floors,
    List<String>? communication,
    List<String>? entrance,
    List<String>? separatedEntrance,
    List<String>? heating,
    List<String>? unloadingAvailability,
    List<String>? objectStatus,
    List<String>? parkingAvailability,
    List<String>? lineOfPlacement,
    List<String>? exclusive,
    List<String>? whoPaysCommunal,
    List<String>? intendedPurpose,
    Object? minPowerElectricity = _sentinel,
    Object? maxPowerElectricity = _sentinel,
    Object? minCeilingHeight = _sentinel,
    Object? maxCeilingHeight = _sentinel,

    // Коммерция (покупка)
    List<String>? objectWithTenants,
    List<String>? landCategory,
    Object? minRentalFlow = _sentinel,
    Object? maxRentalFlow = _sentinel,
    Object? minCadastralObjectCost = _sentinel,
    Object? maxCadastralObjectCost = _sentinel,
    Object? minCadastralLandCost = _sentinel,
    Object? maxCadastralLandCost = _sentinel,
    Object? minCommunalCost = _sentinel,
    Object? maxCommunalCost = _sentinel,
    Object? minPayback = _sentinel,
    Object? maxPayback = _sentinel,

    // Коммерция (аренда)
    List<String>? rentalHolidays,
    Object? minIndexation = _sentinel,
    Object? maxIndexation = _sentinel,
    List<String>? indexationType,

    // Финансы
    Object? minPrice = _sentinel,
    Object? maxPrice = _sentinel,
    Object? minPricePerSquareMeter = _sentinel,
    Object? maxPricePerSquareMeter = _sentinel,
    List<String>? currencies,
    Object? minCommission = _sentinel,
    Object? maxCommission = _sentinel,

    // Текстовый поиск
    String? search,

    // Временные фильтры
    Object? createdFrom = _sentinel,
    Object? createdTo = _sentinel,
    Object? updatedFrom = _sentinel,
    Object? updatedTo = _sentinel,

    // Связи
    Object? ownerContactGuid = _sentinel,

    // Сортировка
    String? sortBy,
    String? sortOrder,
  }) {
    return PropertyFilter(
      userGuid: userGuid == _sentinel ? this.userGuid : userGuid as UuidValue?,
      statuses: statuses ?? this.statuses,
      types: types ?? this.types,
      actionTypes: actionTypes ?? this.actionTypes,
      country: country ?? this.country,
      city: city ?? this.city,
      street: street ?? this.street,
      houseNumber: houseNumber ?? this.houseNumber,
      radius: radius == _sentinel ? this.radius : radius as double?,
      latitude: latitude == _sentinel ? this.latitude : latitude as double?,
      longitude: longitude == _sentinel ? this.longitude : longitude as double?,
      minAreaTotal: minAreaTotal == _sentinel ? this.minAreaTotal : minAreaTotal as double?,
      maxAreaTotal: maxAreaTotal == _sentinel ? this.maxAreaTotal : maxAreaTotal as double?,
      minAreaLiving: minAreaLiving == _sentinel ? this.minAreaLiving : minAreaLiving as double?,
      maxAreaLiving: maxAreaLiving == _sentinel ? this.maxAreaLiving : maxAreaLiving as double?,
      minAreaKitchen: minAreaKitchen == _sentinel ? this.minAreaKitchen : minAreaKitchen as double?,
      maxAreaKitchen: maxAreaKitchen == _sentinel ? this.maxAreaKitchen : maxAreaKitchen as double?,
      minFloorCurrent: minFloorCurrent == _sentinel ? this.minFloorCurrent : minFloorCurrent as int?,
      maxFloorCurrent: maxFloorCurrent == _sentinel ? this.maxFloorCurrent : maxFloorCurrent as int?,
      floorTotal: floorTotal == _sentinel ? this.floorTotal : floorTotal as int?,
      minRoomsTotal: minRoomsTotal == _sentinel ? this.minRoomsTotal : minRoomsTotal as int?,
      maxRoomsTotal: maxRoomsTotal == _sentinel ? this.maxRoomsTotal : maxRoomsTotal as int?,
      minBedrooms: minBedrooms == _sentinel ? this.minBedrooms : minBedrooms as int?,
      maxBedrooms: maxBedrooms == _sentinel ? this.maxBedrooms : maxBedrooms as int?,
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
      whoPaysCommunal: whoPaysCommunal ?? this.whoPaysCommunal,
      intendedPurpose: intendedPurpose ?? this.intendedPurpose,
      minPowerElectricity: minPowerElectricity == _sentinel ? this.minPowerElectricity : minPowerElectricity as double?,
      maxPowerElectricity: maxPowerElectricity == _sentinel ? this.maxPowerElectricity : maxPowerElectricity as double?,
      minCeilingHeight: minCeilingHeight == _sentinel ? this.minCeilingHeight : minCeilingHeight as double?,
      maxCeilingHeight: maxCeilingHeight == _sentinel ? this.maxCeilingHeight : maxCeilingHeight as double?,
      objectWithTenants: objectWithTenants ?? this.objectWithTenants,
      landCategory: landCategory ?? this.landCategory,
      minRentalFlow: minRentalFlow == _sentinel ? this.minRentalFlow : minRentalFlow as double?,
      maxRentalFlow: maxRentalFlow == _sentinel ? this.maxRentalFlow : maxRentalFlow as double?,
      minCadastralObjectCost: minCadastralObjectCost == _sentinel ? this.minCadastralObjectCost : minCadastralObjectCost as double?,
      maxCadastralObjectCost: maxCadastralObjectCost == _sentinel ? this.maxCadastralObjectCost : maxCadastralObjectCost as double?,
      minCadastralLandCost: minCadastralLandCost == _sentinel ? this.minCadastralLandCost : minCadastralLandCost as double?,
      maxCadastralLandCost: maxCadastralLandCost == _sentinel ? this.maxCadastralLandCost : maxCadastralLandCost as double?,
      minCommunalCost: minCommunalCost == _sentinel ? this.minCommunalCost : minCommunalCost as double?,
      maxCommunalCost: maxCommunalCost == _sentinel ? this.maxCommunalCost : maxCommunalCost as double?,
      minPayback: minPayback == _sentinel ? this.minPayback : minPayback as double?,
      maxPayback: maxPayback == _sentinel ? this.maxPayback : maxPayback as double?,
      rentalHolidays: rentalHolidays ?? this.rentalHolidays,
      minIndexation: minIndexation == _sentinel ? this.minIndexation : minIndexation as double?,
      maxIndexation: maxIndexation == _sentinel ? this.maxIndexation : maxIndexation as double?,
      indexationType: indexationType ?? this.indexationType,
      minPrice: minPrice == _sentinel ? this.minPrice : minPrice as double?,
      maxPrice: maxPrice == _sentinel ? this.maxPrice : maxPrice as double?,
      minPricePerSquareMeter: minPricePerSquareMeter == _sentinel ? this.minPricePerSquareMeter : minPricePerSquareMeter as double?,
      maxPricePerSquareMeter: maxPricePerSquareMeter == _sentinel ? this.maxPricePerSquareMeter : maxPricePerSquareMeter as double?,
      currencies: currencies ?? this.currencies,
      minCommission: minCommission == _sentinel ? this.minCommission : minCommission as double?,
      maxCommission: maxCommission == _sentinel ? this.maxCommission : maxCommission as double?,
      search: search ?? this.search,
      createdFrom: createdFrom == _sentinel ? this.createdFrom : createdFrom as DateTime?,
      createdTo: createdTo == _sentinel ? this.createdTo : createdTo as DateTime?,
      updatedFrom: updatedFrom == _sentinel ? this.updatedFrom : updatedFrom as DateTime?,
      updatedTo: updatedTo == _sentinel ? this.updatedTo : updatedTo as DateTime?,
      ownerContactGuid: ownerContactGuid == _sentinel ? this.ownerContactGuid : ownerContactGuid as UuidValue?,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

}