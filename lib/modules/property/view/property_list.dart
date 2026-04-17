import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/components/components.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/property/components/property_filter_view.dart';
import 'package:tennisapp/modules/property/view/property_add_or_edit.dart';
import 'package:tennisapp/modules/property/view/property_profile.dart';
import 'package:tennisapp/modules/venues/view/venues_map.dart';
import 'package:tennisapp/services/service.dart';

import '../bloc/property_list_bloc.dart';
import '../bloc/property_list_events.dart';
import '../bloc/property_list_state.dart';
import 'property_item.dart';



class PropertyList extends StatefulWidget{
  const PropertyList({super.key});

  @override
  State<StatefulWidget> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList>{

  late final PropertyListBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  static const _loadMoreThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _bloc = PropertyListBloc();
    // сразу диспатчим initial
    _bloc.add(OnPropertyListInitialEvent());

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
      _bloc.add(OnPropertyListLoadMoreEvent());
    }
  }

  void _showModalFilter () {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PropertyFilterView();
        }
    ).then((result){
      if(result != null && result){
        _bloc.add(OnPropertyListRefreshListEvent());
      }
    });
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
                              'Список объектов',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Выберите объект для работы',
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
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PropertyAddOrEditView(
                                onSuccessChange: (property){
                                  _bloc.add(OnPropertyListUpdateOneElementEvent(newProperty: property));
                                },
                              )));
                            },
                            icon: Icon(Icons.add_outlined, color: Colors.white, size: 22),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<PropertyListBloc, PropertyListState>(
                      builder: (context, state) {

                        if(state.status == PropertyListStatus.loading){
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
                                _bloc.add(OnPropertyListRefreshListEvent());
                              },
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: state.items.length,
                                separatorBuilder: (context, index) => Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                                itemBuilder: (context, index) {
                                  final property = state.items[index];
                                  return GestureDetector(
                                    onLongPress: () async {
                                      _showCupertinoSelector(context: context, property: property);
                                    },
                                    child: PropertyItem(property: property, bloc: _bloc)
                                  );
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

  Future<void> _showCupertinoSelector({
    required BuildContext context,
    required Property property,
    String cancelText = "Отмена",
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        final isLoadingNotifier = ValueNotifier<bool>(false);

        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push<Property>(MaterialPageRoute(
                    builder: (context) => PropertyProfileView(property: property)
                )).then((property) {
                  if (property != null){
                    _bloc.add(OnPropertyListUpdateOneElementEvent(newProperty: property));
                  }
                });
              },
              child: Text('Просмотр'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                try{
                  final shouldDelete = await showCupertinoDialog<bool>(
                    context: context,
                    builder: (dialogContext) => CupertinoAlertDialog(
                      title: Text('Подтверждение удаления'),
                      content: Text('Вы уверены, что хотите удалить?'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                          child: Text('Отмена'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          isDestructiveAction: true,
                          child: Text('Удалить'),
                        ),
                      ],
                    ),
                  );
                  if(shouldDelete != null && shouldDelete){
                    isLoadingNotifier.value = true;
                    await getIt<PropertyService>().deleteProperty(property.guid);

                    _bloc.add(OnPropertyListUpdateOneElementRemoveEvent(guid: property.guid));
                  }

                  Navigator.of(context).pop();

                }catch(e){
                  isLoadingNotifier.value = false;
                }
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: isLoadingNotifier,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return const Text('Удалить');
                },
              )
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
        );
      },
    );
  }
}