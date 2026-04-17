import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_bloc.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_events.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_state.dart';
import 'package:tennisapp/modules/venues/view/booking/booking_item_view.dart';

class CurrentBookingListView extends StatefulWidget {
  const CurrentBookingListView({super.key});

  @override
  State<CurrentBookingListView> createState() => _CurrentBookingListViewState();
}

class _CurrentBookingListViewState extends State<CurrentBookingListView> {


  late final BookingListBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  static const _loadMoreThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc = BookingListBloc();
    if (!getIt.isRegistered<BookingListBloc>()){
      getIt.registerLazySingleton(() => _bloc);
    }
    // сразу диспатчим initial
    _bloc.add(OnBookingListInitialEvent());


    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bloc.close(); // важно закрыть bloc
    getIt.unregister<BookingListBloc>();
    super.dispose();
  }

  void _onScroll() {
    final state =  _bloc.state;

    // если уже идёт подгрузка или больше нет данных — не триггерим
    if (state.isLoadingMore || !state.hasMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;

    if (maxScroll - current <= _loadMoreThreshold) {
      // reached threshold -> load more
      _bloc.add(OnBookingListLoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context){
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    Row(
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
                                'Мои брони',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Список ваших броней',
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
                    SizedBox(height: 24),
                    BlocBuilder<BookingListBloc, BookingListState>(
                      builder: (context, state) {

                        if(state.status == BookingListStatus.loading){
                          return Center(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return Expanded(
                          child: RefreshIndicator(
                              onRefresh: () async {
                                _bloc.add(OnBookingListRefreshListEvent());
                              },
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: state.items.length,
                                separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(),),
                                itemBuilder: (context, index) {
                                  final booking =  state.items[index];

                                  return BookingItemView(booking: booking, allowViewCanceledButton: false,);
                                },
                              )
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
