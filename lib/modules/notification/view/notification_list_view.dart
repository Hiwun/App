import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/modules/notification/bloc/notificaiton_list_bloc.dart';
import 'package:tennisapp/modules/notification/bloc/notificaiton_list_events.dart';
import 'package:tennisapp/modules/notification/bloc/notification_list_state.dart';
import 'package:tennisapp/modules/notification/view/notification_item_view.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  late final NotificationListBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  static const _loadMoreThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc = NotificationListBloc();
    // сразу диспатчим initial
    _bloc.add(OnNotificationListInitialEvent());

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bloc.close(); // важно закрыть bloc
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
      _bloc.add(OnNotificationListLoadMoreEvent());
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    // Back button and header
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
                                  'Уведомления',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Прочитайте уведомления',
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
                    // Vegetables grid
                    BlocBuilder<NotificationListBloc, NotificationListState>(
                      builder: (context, state) {

                        if(state.status == NotificationListStatus.loading){
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
                              _bloc.add(OnNotificationListRefreshListEvent());
                            },
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: state.items.length,
                              separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                              itemBuilder: (context, index) {
                                final notification = state.items[index];
                                return NotificationItemView(notification: notification);
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
