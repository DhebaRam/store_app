class ProductListModel {
  int? id;
  int? quantity;
  String? title;
  double? price; // Change to double to handle decimal prices
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductListModel({
    this.id,
    this.quantity,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = 1;
    title = json['title'];
    // Safely convert price
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] is double)
            ? json['price']
            : double.tryParse(json['price'].toString()) ?? 0.0;
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = 1;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    // Safely convert rate
    rate = (json['rate'] is double)
        ? json['rate']
        : double.tryParse(json['rate'].toString()) ?? 0.0;
    count = (json['count'] is int)
        ? json['count']
        : (json['count'] is double)
            ? json['count'].toInt()
            : int.tryParse(json['count'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
