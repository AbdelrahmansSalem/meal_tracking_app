import 'dart:typed_data';

class Meal {
  int? id;
  String name;
  String calories;
  String time;
  Uint8List image;
  Meal(this.id, this.name, this.calories, this.time, this.image);
}

extension DataResponseMapper on List<Map<String, dynamic>> {
  List<Meal> toDomain() {
    List<Meal> list = [];
    for (var i = 0; i < length; i++) {
      list.add(Meal(this[i]['id'], this[i]['name'], this[i]['calories'],
          this[i]['time'], this[i]['image']));
    }
    return list;
  }
}
