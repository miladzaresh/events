class MyEventViewModel {
  final String? image;
  final String title;
  final String description;
  final DateTime dateTime;
  final int capacity;
  final int rowCount;
  final int columnCount;
  final int price;
  final int id;
  final int userId;
  final List<PurchaseViewModel> purchases;

  MyEventViewModel({
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.id,
    required this.userId,
    required this.purchases,
    required this.rowCount,
    required this.columnCount,
  });

  MyEventViewModel copyWith({
    String? image,
    String? title,
    String? description,
    DateTime? dateTime,
    int? capacity,
    int? price,
    int? id,
    int? userId,
    List<PurchaseViewModel>? purchases,
    int? rowCount,
    int? columnCount,
  }) =>
      MyEventViewModel(
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        capacity: capacity ?? this.capacity,
        price: price ?? this.price,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        purchases: purchases ?? this.purchases,
        rowCount: rowCount ?? this.rowCount,
        columnCount: columnCount ?? this.columnCount,
      );

  factory MyEventViewModel.fromJson(Map<String, dynamic> json) =>
      MyEventViewModel(
        image: json['image'],
        title: json['title'],
        id: json['id'],
        description: json['description'],
        dateTime: DateTime.tryParse(json['dateTime']) ?? DateTime.now(),
        capacity: json['capacity'],
        price: json['price'],
        userId: json['user_id'],
        columnCount: json['columnCount'],
        rowCount: json['rowCount'],
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
