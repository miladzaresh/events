class BookmarkEventDto{
  final String? image;
  final String title;
  final String description;
  final String dateTime;
  final int capacity;
  final int price;
  final int eventId;
  final int userId;
  final List<PurchaseDto> purchases;
  final int rowCount;
  final int columnCount;
  BookmarkEventDto({
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.eventId,
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
    'event_id':eventId,
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
