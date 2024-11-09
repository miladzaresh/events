
class BookmarkEventViewModel {
  final String? image;
  final String title;
  final String description;
  final String dateTime;
  final int capacity;
  final int price;
  final int eventId;
  final int userId;
  final List<PurchaseViewModel> purchases;
  final int rowCount;
  final int columnCount;

  BookmarkEventViewModel({
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

  factory BookmarkEventViewModel.fromJson(Map<String, dynamic> json) =>
      BookmarkEventViewModel(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        dateTime: json['dateTime'],
        capacity: json['capacity'],
        price: json['price'],
        eventId: json['event_id'],
        userId: json['user_id'],
        purchases: List.from(json['purchases'].map((item)=>PurchaseViewModel.fromJson(item))),
        columnCount: json['columnCount'],
        rowCount: json['rowCount'],
      );
}

class PurchaseViewModel {
  final int userId;
  final bool isPurchase;

  PurchaseViewModel({
    required this.userId,
    required this.isPurchase,
  });

  factory PurchaseViewModel.fromJson(Map<String,dynamic> json) =>PurchaseViewModel(userId: json['userId'], isPurchase: json['isPurchase']);
}
