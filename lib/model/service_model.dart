class ServiceModel {
  final String id;
  final String title;
  final String description;
  final double price; 
  final Duration duration;
  final bool isAddon;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    this.isAddon = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'durationMinutes': duration.inMinutes,
        'isAddon': isAddon,
      };

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final num priceNum = json['price'] ?? 0;
    final num durationNum = json['durationMinutes'] ?? 0;

    return ServiceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: priceNum.toDouble(),
      duration: Duration(minutes: durationNum.toInt()),
      isAddon: json['isAddon'] == true,
    );
  }
}
