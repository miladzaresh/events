class EventDetailsViewModel{
  final String? image;
  final String title;
  final String description;
  final String dateTime;
  final int capacity;
  final int rowCount;
  final int columnCount;
  final int price;
  final int userId;
  final List<PurchaseViewModel> purchases;

  EventDetailsViewModel({
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

  factory EventDetailsViewModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsViewModel(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        dateTime: json['dateTime'],
        capacity: json['capacity'],
        price: json['price'],
        columnCount: json['columnCount'],
        rowCount: json['rowCount'],
        userId: json['user_id'],
        purchases: List<PurchaseViewModel>.from(
            json['purchases'].map((item) => PurchaseViewModel.fromJson(item))),
      );

  Map<String,dynamic> toMap()=>{
    'image':image,
    'title':title,
    'description':description,
    'dateTime':dateTime,
    'capacity':capacity,
    'price':price,
    'columnCount':columnCount,
    'rowCount':rowCount,
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

  Map<String,dynamic> toMap()=>{
    'userId':userId,
    'isPurchase':isPurchase
  };
}
