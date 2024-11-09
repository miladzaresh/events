class BookmarkViewModel {
  final String? image;
  final String title;
  final String description;
  final DateTime dateTime;
  final int capacity;
  final bool isBookmark;
  final int price;
  final int id;
  final int rowCount;
  final int columnCount;
  final int userId;
  final List<PurchaseViewModel> purchases;

  BookmarkViewModel({
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.id,
    required this.userId,
    required this.rowCount,
    required this.columnCount,
    required this.purchases,
    required this.isBookmark,
  });

  BookmarkViewModel copyWith({
    String? image,
    String? title,
    String? description,
    DateTime? dateTime,
    int? capacity,
    int? price,
    int? id,
    int? rowCount,
    int? columnCount,
    int? userId,
    List<PurchaseViewModel>? purchases,
    bool? isBookmark,
  }) =>
      BookmarkViewModel(
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        capacity: capacity ?? this.capacity,
        price: price ?? this.price,
        id: id ?? this.id,
        columnCount: columnCount??this.columnCount,
        rowCount: rowCount??this.rowCount,
        userId: userId ?? this.userId,
        purchases: purchases ?? this.purchases,
        isBookmark: isBookmark ?? this.isBookmark,
      );

  factory BookmarkViewModel.fromJson(Map<String, dynamic> json) => BookmarkViewModel(
    image: json['image'],
    title: json['title'],
    description: json['description'],
    dateTime: DateTime.tryParse(json['dateTime']) ?? DateTime.now(),
    capacity: json['capacity'],
    price: json['price'],
    isBookmark: true,
    id: json['id'],
    rowCount: json['rowCount'],
    columnCount: json['columnCount'],
    userId: json['user_id'],
    purchases: List<PurchaseViewModel>.from(
        json['purchases'].map((item) => PurchaseViewModel.fromJson(item))),
  );

}

class PurchaseViewModel {
  final int userId;
  final bool isPurchase;

  PurchaseViewModel({
    required this.userId,
    required this.isPurchase,
  });

  factory PurchaseViewModel.fromJson(Map<String, dynamic> json) =>
      PurchaseViewModel(
        userId: json['userId'],
        isPurchase: json['isPurchase'],
      );
}
