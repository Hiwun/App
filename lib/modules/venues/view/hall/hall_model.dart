import 'dart:ui';

class HallModel {
  final double width;
  final double height;
  final List<TableModel> tables;

  HallModel({required this.width, required this.height, required this.tables});

  factory HallModel.fromJson(Map<String, dynamic> json) {
    final tables = (json['tables'] as List)
        .map((t) => TableModel.fromJson(t))
        .toList();

    return HallModel(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      tables: tables,
    );
  }
}

class TableModel {
  final String id;
  final String name;
  final Rect rect;
  final String status; // available / reserved / occupied

  TableModel({
    required this.id,
    required this.name,
    required this.rect,
    required this.status,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      name: json['name'],
      rect: Rect.fromLTWH(
        (json['x'] as num).toDouble(),
        (json['y'] as num).toDouble(),
        (json['width'] as num).toDouble(),
        (json['height'] as num).toDouble(),
      ),
      status: json['status'] ?? 'available',
    );
  }
}
