import 'package:uuid/uuid.dart';

abstract class NextEventEvents{}

class NextEventOnInitializedEvent extends NextEventEvents{}
class OnNextEventRequestCancelEvent extends NextEventEvents{
  final UuidValue guid;

  OnNextEventRequestCancelEvent({required this.guid});

}