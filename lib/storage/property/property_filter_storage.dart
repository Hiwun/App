import 'package:tennisapp/storage/storage.dart';

class PropertyFilterStorage {
  PropertyFilter filter;

  PropertyFilterStorage({required this.filter});

  factory PropertyFilterStorage.initial(){
    return PropertyFilterStorage(
      filter: PropertyFilter.create()
    );
  }

  void update(PropertyFilter filter){
    this.filter = filter;
  }
  void clear(){
    filter = PropertyFilter.create();
  }
}