import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/modules/venues/view/venue_item.dart';
import 'package:tennisapp/modules/venues/view/venues_map.dart';

import '../bloc/venue/venue_list_bloc.dart';
import '../bloc/venue/venue_list_events.dart';
import '../bloc/venue/venue_list_state.dart';


class VenueList extends StatefulWidget{
  const VenueList({super.key});

  @override
  State<StatefulWidget> createState() => _VenueListState();
}

class _VenueListState extends State<VenueList>{

  late final VenueListBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  static const _loadMoreThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc = VenueListBloc();
    // сразу диспатчим initial
    _bloc.add(OnVenueListInitialEvent());

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
      _bloc.add(OnVenueListLoadMoreEvent());
    }
  }

  void _showModalFilter () {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close_outlined, size: 20,)
                      ),
                      Text('Фильтры', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: (){
                            
                          },
                          child: Text('Сбросить', style: TextStyle(color: Color.fromRGBO(57,194,125, 1)),)
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(57,194,125, 1)
                                  )
                              ),
                              prefixIcon: Icon(Icons.search, color: Color.fromRGBO(57,194,125, 1), size: 20),
                              hintText: 'Поиск',
                              hintStyle: TextStyle(color: Color(0xFF888888), fontSize: 15),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){

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
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Builder(
        builder: (context){
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
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
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Список заведений',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Выберите заведение в которое хотите пойти',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(57,194,125, 1)
                                    )
                                ),
                                prefixIcon: Icon(Icons.search, color: Color.fromRGBO(57,194,125, 1), size: 20),
                                hintText: 'Поиск',
                                hintStyle: TextStyle(color: Color(0xFF888888), fontSize: 15),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          height: 42,
                          width: 44,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(57,194,125, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VenuesMap()
                              ));
                            },
                            icon: Icon(Icons.map_outlined, color: Colors.white, size: 22),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          height: 42,
                          width: 44,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(57,194,125, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _showModalFilter();
                            },
                            icon: Icon(Icons.filter_alt_outlined, color: Colors.white, size: 22),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<VenueListBloc, VenueListState>(
                      builder: (context, state) {

                        if(state.status == VenueListStatus.loading){
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
                                _bloc.add(OnVenueListRefreshListEvent());
                              },
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: state.items.length,
                                separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                                itemBuilder: (context, index) {
                                  final venue = state.items[index];
                                  return VenueItem(venue: venue);
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