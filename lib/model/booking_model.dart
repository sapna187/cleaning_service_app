import 'package:cleaning_service_selector/model/service_model.dart';

class Booking {
  final String id;
  final DateTime date;
  final List<ServiceModel> items;
  final double total;

  Booking({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'items': items.map((s) => s.toJson()).toList(),
    'total': total,
  };

  factory Booking.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((e) => ServiceModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    final num totalNum = json['total'] ?? 0;
    return Booking(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      items: items,
      total: totalNum.toDouble(),
    );
  }
}
