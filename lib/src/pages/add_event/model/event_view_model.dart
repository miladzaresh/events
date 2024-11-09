class AddEventViewModel {
  final String? image;
  final String title;
  final String description;
  final String dateTime;
  final bool isBookmark;
  final int capacity;
  final int price;
  final int userId;
  final List<PurchaseViewModel> purchases;

  AddEventViewModel({
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.userId,
    required this.purchases,
    required this.isBookmark
  });

  factory AddEventViewModel.fromJson(Map<String, dynamic> json) =>
      AddEventViewModel(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        dateTime: json['dateTime'],
        capacity: json['capacity'],
        price: json['price'],
        isBookmark:json['isBookmark'],
        userId: json['user_id'],
        purchases: List<PurchaseViewModel>.from(
            json['purchases'].map((item) => PurchaseViewModel.fromJson(item))),
      );

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'price': price,
    'capacity': capacity,
    'image': image,
    'dateTime': dateTime,
    'user_id':userId,
    'purchases':purchases.map((e) => e.toMap()).toList()
  };

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
  Map<String, dynamic> toMap() => {'userId': userId, 'isPurchase': isPurchase};

}
