import 'package:cleaning_service_selector/model/services_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookingController extends GetxController {
  final services = servicesList.obs;

  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();
  final selectedIds = <String>[].obs;
  final bookings = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();

  static const double platformFeeRate = 0.10;
  static const double crewShareRate = 0.78;

  @override
  void onInit() {
    super.onInit();
    final saved = storage.read<List>('bookings') ?? [];
    bookings.assignAll(saved.cast<Map<String, dynamic>>());
  }

  void setBookingDate(DateTime date) => selectedDate.value = date;
  void setBookingTime(TimeOfDay time) => selectedTime.value = time;

  void toggleSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }

  double get subtotal => selectedIds
      .map((id) => services.firstWhere((s) => s.id == id).price)
      .fold(0.0, (a, b) => a + b);

  double get platformFee => subtotal * platformFeeRate;
  double get total => subtotal + platformFee;
  double get crewReceives => subtotal * crewShareRate;

  String durationFor(String id) {
    final d = services.firstWhere((s) => s.id == id).duration;
    final minutes = d.inMinutes;
    return '$minutes min';
  }

  void saveBooking() {
    final items = selectedIds
        .map((id) => services.firstWhere((s) => s.id == id))
        .toList();

    final booking = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': selectedDate.value?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      'time': selectedTime.value != null
          ? '${selectedTime.value!.hour}:${selectedTime.value!.minute}'
          : null,
      'items': items.map((s) => s.toJson()).toList(),
      'total': total,
    };

    bookings.add(booking);
    bookings.sort(
      (a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])),
    );

    storage.write('bookings', bookings);
    selectedIds.clear();
    selectedDate.value = null;
    selectedTime.value = null;
  }
}
