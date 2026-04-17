import 'package:flutter/cupertino.dart' hide Table;
import 'package:flutter/material.dart' hide Table;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_events.dart';

import '../../bloc/venue/venue_hall_list_state.dart';
import '../../bloc/venue/venue_tables_availability_list_state.dart';


// -----------------------------
// Экран с залом
// -----------------------------
class HallPainterInfoScreen extends StatefulWidget {


  const HallPainterInfoScreen({super.key});

  @override
  State<HallPainterInfoScreen> createState() => _HallPainterInfoScreenState();
}

class _HallPainterInfoScreenState extends State<HallPainterInfoScreen> {

  DateTime get _initialDate {
    final now = DateTime.now();
    final minute = now.minute;
    final roundedMinute = (minute / 15).round() * 15;
    return DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      roundedMinute,
    );
  }

  late final VenueHallListBloc _venueHallListBloc;
  final TransformationController _controller = TransformationController();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _venueHallListBloc = getIt<VenueHallListBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(Offset position, List<Table> tables) {
    final inverseMatrix = Matrix4.inverted(_controller.value);
    final transformed = MatrixUtils.transformPoint(inverseMatrix, position);

    // Проверяем попадание по столу
    Table? tapped;
    for (final table in tables) {
      final Rect rect = Rect.fromLTWH(table.posX.toDouble(), table.posY.toDouble(), table.width.toDouble(), table.height.toDouble());
      if (rect.contains(transformed)) {
        tapped = table;
        break;
      }
    }

    // Если клик по столу
    if (tapped != null) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.6,
              expand: false, // Важно: запрещаем расширяться
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Полоска-индикатор
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Заголовок
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                          bloc: getIt<VenueTablesAvailabilityListBloc>(),
                          builder: (context, state){
                            return Text(
                              'Занятость стола ${DateFormat('dd.MM, EEE').format(state.requestTime ?? _initialDate)}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                      // Прокручиваемая часть - БЕЗ Expanded
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6 - 100, // Вычитаем высоту заголовка и индикатора
                        child: BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                          bloc: getIt<VenueTablesAvailabilityListBloc>(),
                          builder: (context, state) {
                            final items = state.items.where((item) => item.tableGUID == tapped?.guid).toList();
                            return ListView.builder(
                              controller: controller,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return ListTile(
                                    title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${DateFormat("HH:mm").format(item.startTime.toLocal())} - ${DateFormat("HH:mm").format(item.endTime.toLocal())}'),
                                          Text('Свободен', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.green.shade400)),
                                        ]
                                    )
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
      );
      return;
    }

    // Клик по пустому месту — ничего не делаем
  }

  void _showModalHelper () {
    showModalBottomSheet(
        context: context,
        builder: (context) {
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
                  Text('Изменение даты просмотра', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(
                    'Выберите дату просмотра, а мы запросим данные у заведения',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(250,249,251, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                          bloc: getIt<VenueTablesAvailabilityListBloc>(),
                          builder: (context, state){
                            return InkWell(
                              onTap: () => _showArrivalPicker(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Дата', style: TextStyle(color: Color.fromRGBO(107,108,109, 1), fontWeight: FontWeight.w500)),
                                  Text(
                                      DateFormat('dd.MM, EEE').format(state.requestTime ?? _initialDate),
                                      style: TextStyle(color: Color.fromRGBO(142,143,144, 1))
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showArrivalPicker(BuildContext context) {

    final bloc = getIt<VenueTablesAvailabilityListBloc>();
    DateTime resultDate = bloc.state.requestTime ?? _initialDate;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minuteInterval: 15,
                minimumDate: _initialDate,
                maximumDate: _initialDate.add(Duration(days: 7)),
                use24hFormat: true,
                initialDateTime: bloc.state.requestTime ?? _initialDate,
                onDateTimeChanged: (newDate) {
                  resultDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    ).then((value){

      bloc.add(OnVenueTablesAvailabilityListRefreshEvent(venueGUID: bloc.state.venueGUID, requestTime: resultDate));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    // Back button
                    if (Navigator.of(context).canPop() == true)
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
                    if (Navigator.of(context).canPop() == true)
                      SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Карта зала',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          BlocBuilder<VenueTablesAvailabilityListBloc, VenueTablesAvailabilityListState>(
                            bloc: getIt<VenueTablesAvailabilityListBloc>(),
                            builder: (context, state){
                              return Text(
                                DateFormat('dd.MM, EEE').format(state.requestTime ?? _initialDate),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Выберите столы, которые хотите занять',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 42,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(57,194,125, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showModalHelper();
                        },
                        icon: Icon(Icons.help_center_outlined, color: Colors.white, size: 22),
                        padding: EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BlocBuilder<VenueHallListBloc, VenueHallListState>(
                  bloc: _venueHallListBloc,
                  builder: (context, state){
                    int i = 0;
                    return Wrap(
                      runSpacing: 8,
                      spacing: 5,
                      children: state.items.map((hall){
                        int currIndex = i;
                        i++;
                        return InkWell(
                          onTap: (){
                            setState(() {
                              _currentIndex = currIndex;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                color: _currentIndex == currIndex ? Colors.grey.shade200 : Colors.transparent
                            ),
                            child: Text(hall.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              BlocBuilder<VenueHallListBloc, VenueHallListState>(
                bloc: _venueHallListBloc,
                builder: (context, state){
                  return Expanded(
                    child: GestureDetector(
                      onTapUp: (details) => _onTap(details.localPosition, state.items[_currentIndex].tables),
                      child: InteractiveViewer(
                        transformationController: _controller,
                        minScale: 0.5,
                        maxScale: 3.0,
                        panEnabled: true,
                        scaleEnabled: true,
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(400),
                        child: CustomPaint(
                          size: Size(state.items[_currentIndex].width.toDouble(), state.items[_currentIndex].height.toDouble()),
                          painter: HallPainterInfo(
                            tables: state.items[_currentIndex].tables,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        )
    );
  }
}

// -----------------------------
// Painter — рисует зал
// -----------------------------
class HallPainterInfo extends CustomPainter {
  final List<Table> tables;

  HallPainterInfo({required this.tables});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()..color = Colors.blueAccent;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );

    for (final table in tables) {

      final tableRect = Rect.fromLTWH(table.posX.toDouble(), table.posY.toDouble(), table.width.toDouble(), table.height.toDouble());

      canvas.drawRRect(
        RRect.fromRectAndRadius(tableRect, const Radius.circular(10)),
        _paint,
      );

      // Текст в центре
      textPainter.text = TextSpan(
        text: table.name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      );
      textPainter.layout(maxWidth: tableRect.width);
      final offset = Offset(
        tableRect.left + (tableRect.width - textPainter.width) / 2,
        tableRect.top + (tableRect.height - textPainter.height) / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(HallPainterInfo oldDelegate) => oldDelegate.tables != tables;
}