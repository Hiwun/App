
import 'package:tennisapp/models/model.dart';
import 'package:uuid/uuid.dart';

abstract class PropertyListEvent {}

class OnPropertyListInitialEvent extends PropertyListEvent {}
class OnPropertyListLoadMoreEvent extends PropertyListEvent {}
class OnPropertyListRefreshListEvent extends PropertyListEvent {}
class OnPropertyListUpdateOneElementEvent extends PropertyListEvent {
  final Property newProperty;

  OnPropertyListUpdateOneElementEvent({required this.newProperty});
}
class OnPropertyListUpdateOneElementRemoveEvent extends PropertyListEvent {
  final UuidValue guid;

  OnPropertyListUpdateOneElementRemoveEvent({required this.guid});
}