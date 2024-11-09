class DetailsDto {
  final String? image;
  final String title;
  final String description;
  final String dateTime;
  final int capacity;
  final int rowCount;
  final int columnCount;
  final int price;
  final int userId;
  final List<PurchaseDto> purchases;

  DetailsDto({
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.rowCount,
    required this.columnCount,
    required this.price,
    required this.userId,
    required this.purchases,
  });

  Map<String, dynamic> toMap() => {
        'image': image,
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'capacity': capacity,
        'price': price,
        'columnCount': columnCount,
        'rowCount': rowCount,
        'user_id': userId,
        'purchases': purchases.map((e) => e.toMap()).toList()
      };
}

class PurchaseDto {
  final int userId;
  final bool isPurchase;

  PurchaseDto({
    required this.userId,
    required this.isPurchase,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'isPurchase': isPurchase,
      };
}
