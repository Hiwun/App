import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/components/components.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/enums/enum.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/property/view/property_add_or_edit.dart';
import 'package:tennisapp/storage/storage.dart';

class PropertyProfileView extends StatefulWidget {
  final Property property;
  const PropertyProfileView({super.key, required this.property});

  @override
  State<PropertyProfileView> createState() => _PropertyProfileViewState();
}

class _PropertyProfileViewState extends State<PropertyProfileView> {

  Property _property = Property.create(userGuid: getIt<UserStorage>().user!.guid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _property = widget.property;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final formatter = NumberFormat.simpleCurrency(locale: 'ru');
    return PopScope(
      canPop: false,

      onPopInvokedWithResult: (result, data){
        if (result) return;


        // Возвращаем объект на предыдущий экран
        Navigator.pop(context, _property);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            ImageGetter(
              imageGuid: _property.previewPhotoGUID,
              width: media.width,
              height: media.width,
              fit: BoxFit.cover,
            ),
            Container(
              width: media.width,
              height: media.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: media.width - 60,
                        ),
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
                                InfoField(
                                  title: "Адрес",
                                  value: "${_property.addressStreet}, ${_property.addressHouseNumber}",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                InfoField(
                                  title: "Тип сделки",
                                  value: _property.actionType.toEnum<EnumActionPropertyType>(EnumActionPropertyType.values, fallback: EnumActionPropertyType.None).label,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                InfoField(
                                  title: "Площадь",
                                  value: "${_property.areaTotal} м²",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                InfoField(
                                  title: "Электрическая мощность",
                                  value: "${_property.powerElectricity} кВт",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                InfoField(
                                  title: "Высота потолков",
                                  value: "${_property.ceilingHeight} м",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                InfoField(
                                  title: "Описание",
                                  value: _property.description,
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
                                      InfoField(
                                        title: "Тип недвижимости",
                                        value: _property.realtyType.toEnum<EnumRealtyType>(EnumRealtyType.values, fallback: EnumRealtyType.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Возможно деление",
                                        value: _property.divisionPossible.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Этажи",
                                        value: EnumFloor.values.map((e) => SelectOption(value: e, label: e.label)).toList().labelsOfWithNoneLabel(parseEnumList(_property.floors, EnumFloor.values, EnumFloor.None)),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Коммуникации",
                                        value: EnumCommunication.values.map((e) => SelectOption(value: e, label: e.label)).toList().labelsOfWithNoneLabel(parseEnumList(_property.communication, EnumCommunication.values, EnumCommunication.None)),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Вход",
                                        value: _property.entrance.toEnum<EnumEntrance>(EnumEntrance.values, fallback: EnumEntrance.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Отдельный вход",
                                        value: _property.separatedEntrance.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Отопление",
                                        value: _property.heating.toEnum<EnumHeating>(EnumHeating.values, fallback: EnumHeating.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Наличие разгрузки",
                                        value: _property.unloadingAvailability.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Статус объекта",
                                        value: _property.objectStatus.toEnum<EnumObjectStatus>(EnumObjectStatus.values, fallback: EnumObjectStatus.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Наличие парковки",
                                        value: _property.parkingAvailability.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Линия размещения",
                                        value: _property.lineOfPlacement.toEnum<EnumLineOfPlacement>(EnumLineOfPlacement.values, fallback: EnumLineOfPlacement.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Эксклюзивный объект",
                                        value: _property.exclusive.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Кто оплачивает коммунальные расходы",
                                        value: _property.whoPaysCommunalService.toEnum<EnumWhoPaysCommunal>(EnumWhoPaysCommunal.values, fallback: EnumWhoPaysCommunal.None).label,
                                      ),
                                      InfoField(
                                        title: "Целевое назначение",
                                        value: EnumIntendedPurpose.values.map((e) => SelectOption(value: e, label: e.label)).toList().labelsOfWithNoneLabel(parseEnumList(_property.intendedPurpose, EnumIntendedPurpose.values, EnumIntendedPurpose.None)),
                                      ),
                                      // SelectField<EnumRealtyType>.single(
                                      //   title: "Тип недвижимости",
                                      //   isEditable: true,
                                      //   options: EnumRealtyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                      //   value: _property.realtyType.toEnum(EnumRealtyType.values, fallback: EnumRealtyType.None),
                                      //   onChanged: (val) {
                                      //     setState(() {
                                      //       print(val?.key);
                                      //     });
                                      //   },
                                      // ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                      // SelectField<EnumRealtyType>.multi(
                                      //   title: "Тип недвижимости",
                                      //   isEditable: true,
                                      //   options: EnumRealtyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                                      //   values: parseEnumList<EnumRealtyType>(
                                      //     _property.communication,
                                      //     EnumRealtyType.values,
                                      //     EnumRealtyType.None,
                                      //   ),
                                      //   onMultiChanged: (vals) {
                                      //     print(vals.map((e) => e.key).toList());
                                      //   },
                                      // ),
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
                                      InfoField(
                                        title: "Арендные каникулы",
                                        value: _property.rentalHolidays.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Индексация",
                                        value: "${_property.indexation}%",
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Тип индексации",
                                        value: _property.indexationType.toEnum<EnumIndexType>(EnumIndexType.values, fallback: EnumIndexType.None).label,
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
                                      InfoField(
                                        title: "Объект с арендаторами",
                                        value: _property.objectWithTenants.toEnum<EnumYesOrNo>(EnumYesOrNo.values, fallback: EnumYesOrNo.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Категория земли",
                                        value: _property.landCategory.toEnum<EnumLandCategory>(EnumLandCategory.values, fallback: EnumLandCategory.None).label,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Арендный поток",
                                        value: formatter.format(_property.rentalFlow),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Кадастровая стоимость объекта",
                                        value: formatter.format(_property.cadastralObjectCost),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Кадастровая стоимость земли",
                                        value: formatter.format(_property.cadastralLandCost),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Коммунальные расходы",
                                        value: formatter.format(_property.communalCost),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InfoField(
                                        title: "Окупаемость в годах",
                                        value: "${_property.payback}",
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
                                    InfoField(
                                      title: "Цена",
                                      value: formatter.format(_property.price),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    InfoField(
                                      title: "Цена за квадратный метр",
                                      value: formatter.format(_property.priceForSquareMeter),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    InfoField(
                                      title: "Комиссия",
                                      value: formatter.format(_property.priceForSquareMeter),
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
                                    if (_property.previewPhotoGUID != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Титульное фото",
                                            imageGuids: [
                                              _property.previewPhotoGUID!
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.entrancePhotoGUID != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Фото входной группы",
                                            imageGuids: [
                                              _property.entrancePhotoGUID!
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.unloadingPhotoGUID != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Фото разгрузки",
                                            imageGuids: [
                                              _property.unloadingPhotoGUID!
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.externalPhotoGUIDs.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Внешние фото",
                                            imageGuids: _property.externalPhotoGUIDs,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.internalPhotoGUIDs.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Внутренние фото",
                                            imageGuids: _property.internalPhotoGUIDs,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.locationPhotoGUID != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Фото локации",
                                            imageGuids: [
                                              _property.locationPhotoGUID!
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.planPhotoGUIDs.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Фото планировок",
                                            imageGuids: _property.planPhotoGUIDs,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.otherPhotoGUIDs.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PhotoCarouselField(
                                            title: "Остальные фото",
                                            imageGuids: _property.otherPhotoGUIDs,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
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
                                    if (_property.agencyContract != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FileCarouselField(
                                            title: "Агентский договор",
                                            isEditable: true,
                                            files: _property.agencyContract != null ? [
                                              _property.agencyContract!
                                            ] : null,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.EGRN != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FileCarouselField(
                                            title: "Выписка из ЕГРН",
                                            files: _property.EGRN != null ? [
                                              _property.EGRN!
                                            ] : null,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    if (_property.documents.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FileCarouselField(
                                            title: "Документы",
                                            files: _property.documents,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
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
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    "Теги объекта",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Padding(
                                //   padding:
                                //   const EdgeInsets.symmetric(horizontal: 25),
                                //   child: Wrap(
                                //     runSpacing: 6,
                                //     spacing: 4,
                                //     children: _venue.tags.map((tag) =>
                                //         Container(
                                //           decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.all(Radius.circular(8)),
                                //             border: Border.fromBorderSide(
                                //                 BorderSide(
                                //                     width: 1,
                                //                     color: Color.fromRGBO(57,194,125, 1)
                                //                 )
                                //             ),
                                //           ),
                                //           child: Padding(
                                //             padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                //             child: Text(
                                //               tag,
                                //               style: TextStyle(
                                //                   fontSize: 12
                                //               ),
                                //             ),
                                //           ),
                                //         )
                                //     ).toList(),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: (){
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) => BookingVenueView(venue: _venue)
                                          // ));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1)),
                                        ),
                                        child: Text(
                                          'Предложить клиенту',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context, _property);
                          },
                          icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => HallPainterInfoScreen()
                                // ));
                              },
                              icon: Icon(Icons.map_outlined, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PropertyAddOrEditView(
                                      initialProperty: widget.property,
                                      onSuccessChange: (property){
                                        setState(() {
                                          _property = property;
                                        });
                                      },
                                    )
                                ));
                              },
                              icon: Icon(Icons.edit_outlined, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}