import 'package:flutter/material.dart' hide Table;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_event.dart';
import 'package:tennisapp/modules/venues/bloc/booking/booking_venue_state.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_bloc.dart' show VenueHallListBloc;
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_state.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_bloc.dart';

import 'hall_model.dart';


// -----------------------------
// Экран с залом
// -----------------------------
class HallPainterScreen extends StatefulWidget {
  const HallPainterScreen({super.key});

  @override
  State<HallPainterScreen> createState() => _HallPainterScreenState();
}

class _HallPainterScreenState extends State<HallPainterScreen> {
  late final List<TableModel> tables;
  late final double hallWidth;
  late final double hallHeight;

  late final VenueHallListBloc _venueHallListBloc;
  final TransformationController _controller = TransformationController();

  int _currentIndex = 0;

  Set<String> selectedIds = {}; // множественный выбор

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
    final List<TableAvailability> tableAvailabilities = getIt<VenueTablesAvailabilityListBloc>().state.items;
    final BookingVenueBloc bookingVenueBloc = getIt<BookingVenueBloc>();
    final currentTablesBloc = bookingVenueBloc.state.tables;
    // Если клик по столу

      if(tapped != null && tableAvailabilities.any((item) {
        final itemStart = item.startTime.toLocal();
        final itemEnd = item.endTime.toLocal();
        final bookingStart = bookingVenueBloc.state.startTime.toLocal();
        final bookingEnd = bookingVenueBloc.state.expectedEndTime.toLocal();

        return (itemStart.isBefore(bookingStart) || itemStart.isAtSameMomentAs(bookingStart)) &&
            (itemEnd.isAfter(bookingEnd) || itemEnd.isAtSameMomentAs(bookingEnd));
      })) {
        setState(() {
          if (currentTablesBloc.any((item) => item.tableGUID == tapped!.guid)) {
            bookingVenueBloc.add(OnBookingVenueUpdateEvent(tables: currentTablesBloc.where((item) => item.tableGUID != tapped!.guid).toList()));
          } else {
            final BookingTable bookingTable = BookingTable(
              tableGUID: tapped!.guid,
              bookingGUID: bookingVenueBloc.state.guid,
              title: tapped.name,
            );
            bookingVenueBloc.add(OnBookingVenueUpdateEvent(tables: [...currentTablesBloc, bookingTable]));
          }
        }
      );
      return;
    }

    // Клик по пустому месту — ничего не делаем
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
                  child: BlocBuilder<BookingVenueBloc, BookingVenueState>(
                    bloc: getIt<BookingVenueBloc>(),
                    builder: (context, stateBooking){
                      return GestureDetector(
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
                            painter: HallPainter(
                                tables: state.items[_currentIndex].tables,
                                selectedBookings: stateBooking.tables
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

// -----------------------------
// Painter — рисует зал
// -----------------------------
class HallPainter extends CustomPainter {
  final List<Table> tables;
  final List<BookingTable> selectedBookings;

  HallPainter({required this.tables, required this.selectedBookings});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintAvailable = Paint()..color = Colors.blueAccent;
    final Paint paintReserved = Paint()..color = Colors.orange;
    final Paint paintSelected = Paint()..color = Colors.green;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final VenueTablesAvailabilityListBloc _venueTablesBloc = getIt<VenueTablesAvailabilityListBloc>();
    final BookingVenueBloc _venueBookingBloc = getIt<BookingVenueBloc>();

    for (final table in tables) {
      Paint paint;
      final List<TableAvailability> tableAvailabilities = _venueTablesBloc.state.items.where((item) => item.tableGUID == table.guid).toList();

      if (selectedBookings.any((item) => item.tableGUID == table.guid)) {
        paint = paintSelected;
      } else {
        String status = "";

        if(!tableAvailabilities.any((item) {
          final itemStart = item.startTime.toLocal();
          final itemEnd = item.endTime.toLocal();
          final bookingStart = _venueBookingBloc.state.startTime.toLocal();
          final bookingEnd = _venueBookingBloc.state.expectedEndTime.toLocal();

          return (itemStart.isBefore(bookingStart) || itemStart.isAtSameMomentAs(bookingStart)) &&
              (itemEnd.isAfter(bookingEnd) || itemEnd.isAtSameMomentAs(bookingEnd));
        })) {
          status = "reserved";
        }
        switch (status) {
          case 'reserved':
            paint = paintReserved;
            break;
          default:
            paint = paintAvailable;
        }
      }

      final Rect rect = Rect.fromLTWH(table.posX.toDouble(), table.posY.toDouble(), table.width.toDouble(), table.height.toDouble());

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        paint,
      );

      // Текст в центре
      textPainter.text = TextSpan(
        text: table.name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      );
      textPainter.layout(maxWidth: rect.width);
      final offset = Offset(
        rect.left + (rect.width - textPainter.width) / 2,
        rect.top + (rect.height - textPainter.height) / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(HallPainter oldDelegate) =>
      oldDelegate.tables != tables || oldDelegate.selectedBookings != selectedBookings;
}