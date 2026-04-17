import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/components/components.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/enums/enum.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/storage/storage.dart';

class PropertyAddOrEditView extends StatefulWidget {
  final Property? initialProperty;
  final Function(Property)? onSuccessChange;
  const PropertyAddOrEditView({
    super.key,
    this.initialProperty,
    this.onSuccessChange,
  });

  @override
  State<PropertyAddOrEditView> createState() => _PropertyAddOrEditViewState();
}

class _PropertyAddOrEditViewState extends State<PropertyAddOrEditView> {

  Property _property = Property.create(userGuid: getIt<UserStorage>().user!.guid);
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _property = widget.initialProperty ??
        Property.create(userGuid: getIt<UserStorage>().user!.guid);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final formatter = NumberFormat.simpleCurrency(locale: 'ru');
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        // Back button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.grey[700], size: 20),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Редактирование',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Заполните характеристики объекта',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              _property.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Тип объекта",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      _property.type.toEnum<EnumPropertyType>(EnumPropertyType.values, fallback: EnumPropertyType.Apartment).label,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      _property.status.toEnum<EnumPropertyStatus>(EnumPropertyStatus.values, fallback: EnumPropertyStatus.None).label,
                                      style: TextStyle(
                                          color: Colors.green.shade300,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Основная информация",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                            title: 'Наименование',
                            initialValue: _property.title,
                            hint: 'Наименование',
                            onChanged: (newValue){
                              setState(() {
                                _property = _property.copyWith(title: newValue);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SelectField<EnumPropertyType>.single(
                            title: "Тип объекта",
                            isEditable: true,
                            options: EnumPropertyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                            value: _property.type.toEnum(EnumPropertyType.values, fallback: EnumPropertyType.Apartment),
                            onChanged: (val) {
                              setState(() {
                                _property = _property.copyWith(type: val?.key ?? "None");
                              });
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SelectField<EnumActionPropertyType>.single(
                            title: "Тип сделки",
                            isEditable: true,
                            options: EnumActionPropertyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                            value: _property.actionType.toEnum(EnumActionPropertyType.values, fallback: EnumActionPropertyType.None),
                            onChanged: (val) {
                              setState(() {
                                _property = _property.copyWith(actionType: val?.key ?? "None");
                              });
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          NumberField(
                            title: 'Площадь',
                            initialValue: _property.areaTotal,
                            hint: '0',
                            suffixText: 'м²',
                            onChanged: (newValue){
                              setState(() {
                                _property = _property.copyWith(areaTotal: newValue);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          NumberField(
                            title: 'Электрическая мощность',
                            initialValue: _property.powerElectricity,
                            hint: '0',
                            suffixText: 'кВт',
                            onChanged: (newValue){
                              setState(() {
                                _property = _property.copyWith(powerElectricity: newValue);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          NumberField(
                            title: 'Высота потолков',
                            initialValue: _property.ceilingHeight,
                            hint: '0',
                            suffixText: 'м',
                            onChanged: (newValue){
                              setState(() {
                                _property = _property.copyWith(ceilingHeight: newValue);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextAreaField(
                            title: 'Описание',
                            initialValue: _property.description,
                            hint: 'Введите текст',
                            onChanged: (newValue){
                              setState(() {
                                _property = _property.copyWith(description: newValue);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25),
                              child: Divider(
                                color:
                                Colors.black.withOpacity(0.4),
                                height: 1,
                              )
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Адресс",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppTextField(
                                title: 'Область',
                                initialValue: _property.addressCountry,
                                hint: 'Пример. Ярославская',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(addressCountry: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              AppTextField(
                                title: 'Город',
                                initialValue: _property.addressCity,
                                hint: 'Пример. Ярославль',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(addressCity: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              AppTextField(
                                title: 'Улица',
                                initialValue: _property.addressStreet,
                                hint: 'Пример. Свободы',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(addressStreet: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              AppTextField(
                                title: 'Номер здания',
                                initialValue: _property.addressHouseNumber,
                                hint: 'Пример. 34',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(addressHouseNumber: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              AppTextField(
                                title: 'Номер помещения',
                                initialValue: _property.addressApartmentNumber,
                                hint: 'Пример. 1',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(addressApartmentNumber: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              NumberField(
                                title: 'Широта',
                                initialValue: _property.latitude,
                                ifNullReturnNull: true,
                                hint: '0',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(latitude: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              NumberField(
                                title: 'Долгота',
                                initialValue: _property.longitude,
                                ifNullReturnNull: true,
                                hint: '0',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(longitude: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Divider(
                                    color:
                                    Colors.black.withOpacity(0.4),
                                    height: 1,
                                  )
                              ),
                            ],
                          ),

                          if (_property.type == "Commercial")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    "Технический блок",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SelectField<EnumRealtyType>.single(
                                  title: "Тип недвижимости",
                                  isEditable: true,
                                  options: EnumRealtyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.realtyType.toEnum(EnumRealtyType.values, fallback: EnumRealtyType.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(realtyType: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Возможно деление",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.divisionPossible.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(divisionPossible: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumFloor>.multi(
                                  title: "Этажи",
                                  isEditable: true,
                                  options: EnumFloor.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  values: parseEnumList<EnumFloor>(
                                    _property.floors,
                                    EnumFloor.values,
                                    EnumFloor.None,
                                  ),
                                  onMultiChanged: (vals) {
                                    setState(() {
                                      _property = _property.copyWith(floors: vals.map((e) => e.key).toList());
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumCommunication>.multi(
                                  title: "Коммуникации",
                                  isEditable: true,
                                  options: EnumCommunication.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  values: parseEnumList<EnumCommunication>(
                                    _property.communication,
                                    EnumCommunication.values,
                                    EnumCommunication.None,
                                  ),
                                  onMultiChanged: (vals) {
                                    setState(() {
                                      _property = _property.copyWith(communication: vals.map((e) => e.key).toList());
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumEntrance>.single(
                                  title: "Вход",
                                  isEditable: true,
                                  options: EnumEntrance.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.entrance.toEnum(EnumEntrance.values, fallback: EnumEntrance.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(entrance: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Отдельный вход",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.separatedEntrance.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(separatedEntrance: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumHeating>.single(
                                  title: "Отопление",
                                  isEditable: true,
                                  options: EnumHeating.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.heating.toEnum(EnumHeating.values, fallback: EnumHeating.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(heating: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Наличие разгрузки",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.unloadingAvailability.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(unloadingAvailability: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumObjectStatus>.single(
                                  title: "Статус объекта",
                                  isEditable: true,
                                  options: EnumObjectStatus.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.objectStatus.toEnum(EnumObjectStatus.values, fallback: EnumObjectStatus.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(objectStatus: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Наличие парковки",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.parkingAvailability.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(parkingAvailability: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumLineOfPlacement>.single(
                                  title: "Линия размещения",
                                  isEditable: true,
                                  options: EnumLineOfPlacement.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.lineOfPlacement.toEnum(EnumLineOfPlacement.values, fallback: EnumLineOfPlacement.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(lineOfPlacement: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Эксклюзивный объект",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.exclusive.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(exclusive: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumWhoPaysCommunal>.single(
                                  title: "Кто оплачивает коммунальные расходы",
                                  isEditable: true,
                                  options: EnumWhoPaysCommunal.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.whoPaysCommunalService.toEnum(EnumWhoPaysCommunal.values, fallback: EnumWhoPaysCommunal.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(whoPaysCommunalService: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumIntendedPurpose>.multi(
                                  title: "Целевое назначение",
                                  isEditable: true,
                                  options: EnumIntendedPurpose.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  values: parseEnumList<EnumIntendedPurpose>(
                                    _property.intendedPurpose,
                                    EnumIntendedPurpose.values,
                                    EnumIntendedPurpose.None,
                                  ),
                                  onMultiChanged: (vals) {
                                    setState(() {
                                      _property = _property.copyWith(intendedPurpose: vals.map((e) => e.key).toList());
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Divider(
                                      color:
                                      Colors.black.withOpacity(0.4),
                                      height: 1,
                                    )
                                ),
                              ],
                            ),

                          if (_property.type == "Commercial" && _property.actionType == "Rent")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    "Коммерция аренда",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Арендные каникулы",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.rentalHolidays.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(rentalHolidays: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                NumberField(
                                  title: 'Индексация',
                                  initialValue: _property.indexation,
                                  hint: '0',
                                  suffixText: '%',
                                  onChanged: (newValue){
                                    setState(() {
                                      _property = _property.copyWith(indexation: newValue);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumIndexType>.single(
                                  title: "Тип индексации",
                                  isEditable: true,
                                  options: EnumIndexType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.indexationType.toEnum(EnumIndexType.values, fallback: EnumIndexType.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(indexationType: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Divider(
                                      color:
                                      Colors.black.withOpacity(0.4),
                                      height: 1,
                                    )
                                ),
                              ],
                            ),
                          if (_property.type == "Commercial" && _property.actionType == "Sell")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    "Коммерция продажа",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumYesOrNo>.single(
                                  title: "Объект с арендаторами",
                                  isEditable: true,
                                  options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.objectWithTenants.toEnum(EnumYesOrNo.values, fallback: EnumYesOrNo.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(objectWithTenants: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SelectField<EnumLandCategory>.single(
                                  title: "Категория земли",
                                  isEditable: true,
                                  options: EnumLandCategory.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                  value: _property.landCategory.toEnum(EnumLandCategory.values, fallback: EnumLandCategory.None),
                                  onChanged: (val) {
                                    setState(() {
                                      _property = _property.copyWith(landCategory: val?.key ?? "None");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CurrencyField(
                                  title: 'Арендный поток',
                                  initialValue: _property.rentalFlow,
                                  hint: '0',
                                  onChanged: (newValue){
                                    setState(() {
                                      _property = _property.copyWith(rentalFlow: newValue);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CurrencyField(
                                  title: 'Кадастровая стоимость объекта',
                                  initialValue: _property.cadastralObjectCost,
                                  hint: '0',
                                  onChanged: (newValue){
                                    setState(() {
                                      _property = _property.copyWith(cadastralObjectCost: newValue);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CurrencyField(
                                  title: 'Кадастровая стоимость земли',
                                  initialValue: _property.cadastralLandCost,
                                  hint: '0',
                                  onChanged: (newValue){
                                    setState(() {
                                      _property = _property.copyWith(cadastralLandCost: newValue);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CurrencyField(
                                  title: 'Коммунальные расходы',
                                  initialValue: _property.communalCost,
                                  hint: '0',
                                  onChanged: (newValue){
                                    setState(() {
                                      _property = _property.copyWith(communalCost: newValue);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                NumberField(
                                  title: 'Окупаемость в годах',
                                  initialValue: _property.payback,
                                  hint: '0',
                                  onChanged: (newValue){
                                    setState(() {
                                      _property = _property.copyWith(payback: newValue);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Divider(
                                      color:
                                      Colors.black.withOpacity(0.4),
                                      height: 1,
                                    )
                                ),
                              ],
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Коммерческий блок",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CurrencyField(
                                title: 'Цена',
                                initialValue: _property.price,
                                hint: '0',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(price: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CurrencyField(
                                title: 'Цена за квадратный метр',
                                initialValue: _property.priceForSquareMeter,
                                hint: '0',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(priceForSquareMeter: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CurrencyField(
                                title: 'Комиссия',
                                initialValue: _property.commission,
                                hint: '0',
                                onChanged: (newValue){
                                  setState(() {
                                    _property = _property.copyWith(commission: newValue);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Divider(
                                    color:
                                    Colors.black.withOpacity(0.4),
                                    height: 1,
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Фотографии",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Титульное фото",
                                isEditable: true,
                                canRemove: true,
                                imageGuids: _property.previewPhotoGUID != null ? [
                                  _property.previewPhotoGUID!
                                ] : null,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(previewPhotoGUID: newValues?.firstOrNull);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Фото входной группы",
                                isEditable: true,
                                canRemove: true,
                                imageGuids: _property.entrancePhotoGUID != null ? [
                                  _property.entrancePhotoGUID!
                                ] : null,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    final t = newValues?.firstOrNull;
                                    _property = _property.copyWith(entrancePhotoGUID: newValues?.firstOrNull);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Фото разгрузки",
                                isEditable: true,
                                canRemove: true,
                                imageGuids: _property.unloadingPhotoGUID != null ? [
                                  _property.unloadingPhotoGUID!
                                ] : null,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(unloadingPhotoGUID: newValues?.firstOrNull);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Внешние фото",
                                isEditable: true,
                                multiple: true,
                                canRemove: true,
                                imageGuids: _property.externalPhotoGUIDs,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(externalPhotoGUIDs: newValues ?? []);
                                  });
                                }
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Внутренние фото",
                                isEditable: true,
                                multiple: true,
                                canRemove: true,
                                imageGuids: _property.internalPhotoGUIDs,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(internalPhotoGUIDs: newValues ?? []);
                                  });
                                }
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Фото локации",
                                isEditable: true,
                                canRemove: true,
                                imageGuids: _property.locationPhotoGUID != null ? [
                                  _property.locationPhotoGUID!
                                ] : null,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(locationPhotoGUID: newValues?.firstOrNull);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Фото планировок",
                                isEditable: true,
                                multiple: true,
                                canRemove: true,
                                imageGuids: _property.planPhotoGUIDs,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(planPhotoGUIDs: newValues ?? []);
                                  });
                                }
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              PhotoCarouselField(
                                title: "Остальные фото",
                                isEditable: true,
                                multiple: true,
                                canRemove: true,
                                imageGuids: _property.otherPhotoGUIDs,
                                onChangeGuids: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(otherPhotoGUIDs: newValues ?? []);
                                  });
                                }
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Divider(
                                    color:
                                    Colors.black.withOpacity(0.4),
                                    height: 1,
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Документы",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FileCarouselField(
                                title: "Агентский договор",
                                isEditable: true,
                                canRemove: true,
                                files: _property.agencyContract != null ? [_property.agencyContract!] : null,
                                onChangeFiles: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(agencyContractGUID: newValues?.firstOrNull?.guid, agencyContract: newValues?.firstOrNull);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FileCarouselField(
                                title: "Выписка из ЕГРН",
                                isEditable: true,
                                canRemove: true,
                                files: _property.EGRN != null ? [_property.EGRN!] : null,
                                onChangeFiles: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(EGRNGUID: newValues?.firstOrNull?.guid, EGRN: newValues?.firstOrNull);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FileCarouselField(
                                title: "Документы",
                                isEditable: true,
                                multiple: true,
                                canRemove: true,
                                files: _property.documents,
                                onChangeFiles: (newValues){
                                  setState(() {
                                    _property = _property.copyWith(documents: newValues ?? [], documentsGUIDs: newValues?.map((e) => e.guid).toList() ?? []);
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          try{
                            setState(() {
                              isLoading = true;
                            });
                            if(widget.initialProperty != null){
                              await getIt<PropertyService>().updateProperty(_property);
                            } else {
                              await getIt<PropertyService>().createProperty(_property);
                            }
                            final successProperty = await getIt<PropertyService>().getPropertyByGuid(_property.guid);
                            if(widget.onSuccessChange != null && successProperty.data != null){
                              widget.onSuccessChange!(successProperty.data!);
                            }
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          } catch(e) {
                            print('ttt');
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                        ),
                        child: !isLoading ? Text(
                          widget.initialProperty != null ? 'Сохранить' : 'Создать',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ) : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                    ),
                  ),
                ]
              ),
            ),
          ),
        )
    );
  }
}