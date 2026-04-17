import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/modules/promo/view/promo_item_view.dart';

import '../bloc/promo_list_bloc.dart';
import '../bloc/promo_list_events.dart';
import '../bloc/promo_list_state.dart';

class PromoListView extends StatefulWidget {
  const PromoListView({super.key});

  @override
  State<PromoListView> createState() => _PromoListViewState();
}

class _PromoListViewState extends State<PromoListView> {

  late final PromoListBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  static const _loadMoreThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc = PromoListBloc();
    // сразу диспатчим initial
    _bloc.add(OnPromoListInitialEvent());

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
      _bloc.add(OnPromoListLoadMoreEvent());
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Акции',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Уникальные предложения партнеров',
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
                    BlocBuilder<PromoListBloc, PromoListState>(
                      builder: (context, state) {

                        if(state.status == PromoListStatus.loading){
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
                                _bloc.add(OnPromoListRefreshListEvent());
                              },
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: state.items.length,
                                separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(),),
                                itemBuilder: (context, index) {
                                  final promo = state.items[index];
                                  return PromoItemView(promotion: promo);
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
