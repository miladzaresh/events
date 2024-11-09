class AddEventDto {
  final String? image;
  final String title;
  final String description;
  final String dateTime;
  final int capacity;
  final int rowCount;
  final int columnCount;
  final int userId;
  final int price;
  final List<PurchaseDto> purchases;

  AddEventDto({
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.userId,
    required this.purchases,
    required this.columnCount,
    required this.rowCount,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'price': price,
        'capacity': capacity,
        'image': image,
        'dateTime': dateTime,
        'user_id':userId,
        'rowCount':rowCount,
        'columnCount':columnCount,
        'purchases':purchases.map((e) => e.toMap()).toList()
      };
}

class PurchaseDto {
  final int userId;
  final bool isPurchase;

  PurchaseDto({
    required this.userId,
    required this.isPurchase,
  });

  Map<String, dynamic> toMap() => {'userId': userId, 'isPurchase': isPurchase};
}
