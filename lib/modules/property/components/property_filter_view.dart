import 'package:flutter/material.dart';
import 'package:tennisapp/components/components.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/enums/enum.dart';
import 'package:tennisapp/storage/storage.dart';

class PropertyFilterView extends StatefulWidget {
  const PropertyFilterView({super.key});

  @override
  State<PropertyFilterView> createState() => _PropertyFilterViewState();
}

class _PropertyFilterViewState extends State<PropertyFilterView> {

  PropertyFilter filter = getIt<PropertyFilterStorage>().filter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: (){
                      getIt<PropertyFilterStorage>().clear();
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Сбросить', style: TextStyle(color: Color.fromRGBO(57,194,125, 1)),)
                ),
                Text('Фильтры', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                TextButton(
                    onPressed: (){
                      getIt<PropertyFilterStorage>().update(filter);
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Применить', style: TextStyle(color: Color.fromRGBO(57,194,125, 1)),)
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      title: 'Поиск',
                      initialValue: filter.search,
                      hint: 'Поиск',
                      padding: null,
                      onChanged: (newValue){
                        setState(() {
                          filter = filter.copyWith(search: newValue);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumPropertyStatus>.multi(
                      title: "Статусы",
                      isEditable: true,
                      padding: null,
                      options: EnumPropertyStatus.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumPropertyStatus>(
                        filter.statuses,
                        EnumPropertyStatus.values,
                        EnumPropertyStatus.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(statuses: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumPropertyType>.multi(
                      title: "Тип объекта",
                      isEditable: true,
                      padding: null,
                      options: EnumPropertyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumPropertyType>(
                        filter.types,
                        EnumPropertyType.values,
                        EnumPropertyType.Apartment,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(types: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumActionPropertyType>.multi(
                      title: "Тип сделки",
                      isEditable: true,
                      padding: null,
                      options: EnumActionPropertyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumActionPropertyType>(
                        filter.actionTypes,
                        EnumActionPropertyType.values,
                        EnumActionPropertyType.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(actionTypes: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    NumberRangeField(
                      title: 'Площадь',
                      initialValueFrom: filter.minAreaTotal,
                      initialValueTo: filter.maxAreaTotal,
                      hintFrom: 'от',
                      hintTo: 'до',
                      suffixText: 'м²',
                      padding: null,
                      ifNullReturnNull: true,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minAreaTotal: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxAreaTotal: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    NumberRangeField(
                      title: 'Электрическая мощность',
                      initialValueFrom: filter.minPowerElectricity,
                      initialValueTo: filter.maxPowerElectricity,
                      hintFrom: 'от',
                      hintTo: 'до',
                      suffixText: 'кВт',
                      padding: null,
                      ifNullReturnNull: true,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minPowerElectricity: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxPowerElectricity: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    NumberRangeField(
                      title: 'Высота потолков',
                      initialValueFrom: filter.minCeilingHeight,
                      initialValueTo: filter.maxCeilingHeight,
                      hintFrom: 'от',
                      hintTo: 'до',
                      suffixText: 'м',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minCeilingHeight: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxCeilingHeight: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Цена',
                      initialValueFrom: filter.minPrice,
                      initialValueTo: filter.maxPrice,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minPrice: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxPrice: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Цена за квадратный метр',
                      initialValueFrom: filter.minPricePerSquareMeter,
                      initialValueTo: filter.maxPricePerSquareMeter,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minPricePerSquareMeter: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxPricePerSquareMeter: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    NumberRangeField(
                      title: 'Окупаемость в годах',
                      initialValueFrom: filter.minPayback,
                      initialValueTo: filter.maxPayback,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minPayback: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxPayback: newValue);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumRealtyType>.multi(
                      title: "Тип недижимости",
                      isEditable: true,
                      padding: null,
                      options: EnumRealtyType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumRealtyType>(
                        filter.realtyType,
                        EnumRealtyType.values,
                        EnumRealtyType.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(realtyType: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Возможно ли деление",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.divisionPossible,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(divisionPossible: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumFloor>.multi(
                      title: "Этажи",
                      isEditable: true,
                      padding: null,
                      options: EnumFloor.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumFloor>(
                        filter.floors,
                        EnumFloor.values,
                        EnumFloor.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(floors: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumCommunication>.multi(
                      title: "Коммуникации",
                      isEditable: true,
                      padding: null,
                      options: EnumCommunication.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumCommunication>(
                        filter.communication,
                        EnumCommunication.values,
                        EnumCommunication.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(communication: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumEntrance>.multi(
                      title: "Тип входа",
                      isEditable: true,
                      padding: null,
                      options: EnumEntrance.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumEntrance>(
                        filter.entrance,
                        EnumEntrance.values,
                        EnumEntrance.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(entrance: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Отдельный вход",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.separatedEntrance,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(separatedEntrance: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumHeating>.multi(
                      title: "Отопление",
                      isEditable: true,
                      padding: null,
                      options: EnumHeating.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumHeating>(
                        filter.heating,
                        EnumHeating.values,
                        EnumHeating.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(heating: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Наличие разгрузки",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.unloadingAvailability,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(unloadingAvailability: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumObjectStatus>.multi(
                      title: "Статус объекта",
                      isEditable: true,
                      padding: null,
                      options: EnumObjectStatus.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumObjectStatus>(
                        filter.objectStatus,
                        EnumObjectStatus.values,
                        EnumObjectStatus.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(objectStatus: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Наличие парковки",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.parkingAvailability,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(parkingAvailability: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumLineOfPlacement>.multi(
                      title: "Линия размещения",
                      isEditable: true,
                      padding: null,
                      options: EnumLineOfPlacement.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumLineOfPlacement>(
                        filter.lineOfPlacement,
                        EnumLineOfPlacement.values,
                        EnumLineOfPlacement.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(lineOfPlacement: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Эксклюзивность",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.exclusive,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(exclusive: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumWhoPaysCommunal>.multi(
                      title: "Кто платит коммуналку",
                      isEditable: true,
                      padding: null,
                      options: EnumWhoPaysCommunal.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumWhoPaysCommunal>(
                        filter.whoPaysCommunal,
                        EnumWhoPaysCommunal.values,
                        EnumWhoPaysCommunal.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(whoPaysCommunal: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumIntendedPurpose>.multi(
                      title: "Целевое назначение",
                      isEditable: true,
                      padding: null,
                      options: EnumIntendedPurpose.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumIntendedPurpose>(
                        filter.intendedPurpose,
                        EnumIntendedPurpose.values,
                        EnumIntendedPurpose.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(intendedPurpose: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Объект с арендаторами",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.objectWithTenants,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(objectWithTenants: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumLandCategory>.multi(
                      title: "Категория земель",
                      isEditable: true,
                      padding: null,
                      options: EnumLandCategory.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumLandCategory>(
                        filter.landCategory,
                        EnumLandCategory.values,
                        EnumLandCategory.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(landCategory: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumYesOrNo>.multi(
                      title: "Арендные каникулы",
                      isEditable: true,
                      padding: null,
                      options: EnumYesOrNo.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumYesOrNo>(
                        filter.rentalHolidays,
                        EnumYesOrNo.values,
                        EnumYesOrNo.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(rentalHolidays: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectField<EnumIndexType>.multi(
                      title: "Тип индексации",
                      isEditable: true,
                      padding: null,
                      options: EnumIndexType.values.map((e) => SelectOption(value: e, label: e.label)).toList(),
                      values: parseEnumList<EnumIndexType>(
                        filter.indexationType,
                        EnumIndexType.values,
                        EnumIndexType.None,
                      ),
                      onMultiChanged: (vals) {
                        setState(() {
                          filter = filter.copyWith(indexationType: vals.map((e) => e.key).toList());
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    NumberRangeField(
                      title: 'Индексация',
                      initialValueFrom: filter.minIndexation,
                      initialValueTo: filter.maxIndexation,
                      hintFrom: 'от',
                      hintTo: 'до',
                      suffixText: '%',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minIndexation: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxIndexation: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Комиссия',
                      initialValueFrom: filter.minCommission,
                      initialValueTo: filter.maxCommission,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minCommission: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxCommission: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Арендный поток',
                      initialValueFrom: filter.minRentalFlow,
                      initialValueTo: filter.maxRentalFlow,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minRentalFlow: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxRentalFlow: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Кадастровая стоимость объекта',
                      initialValueFrom: filter.minCadastralObjectCost,
                      initialValueTo: filter.maxCadastralObjectCost,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minCadastralObjectCost: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxCadastralObjectCost: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Кадастровая стоимость земли',
                      initialValueFrom: filter.minCadastralLandCost,
                      initialValueTo: filter.maxCadastralLandCost,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minCadastralLandCost: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxCadastralLandCost: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    CurrencyRangeField(
                      title: 'Коммунальные расходы',
                      initialValueFrom: filter.minCommunalCost,
                      initialValueTo: filter.maxCommunalCost,
                      hintFrom: 'от',
                      hintTo: 'до',
                      ifNullReturnNull: true,
                      padding: null,
                      onChangedFrom: (newValue){
                        setState(() {
                          filter = filter.copyWith(minCommunalCost: newValue);
                        });
                      },
                      onChangedTo: (newValue){
                        setState(() {
                          filter = filter.copyWith(maxCommunalCost: newValue);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (){
                            getIt<PropertyFilterStorage>().update(filter);
                            Navigator.of(context).pop(true);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(57,194,125, 1)),
                          ),
                          child: Text(
                            'Применить',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
