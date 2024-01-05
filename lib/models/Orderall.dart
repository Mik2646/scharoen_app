class Orderalls {
  String? id;
  String? typeroof;
  String? brand_roof;
  String? color_roof;
  String? size_roof;
  String? length_roof;
  String? amount_roof;
  String? cover_roof;
  String? length_cover;
  String? amount_cover;
  DateTime? orderitem_created;
  String? orderitem_status;

  Orderalls(
      {required this.id,
      required this.typeroof,
      required this.brand_roof,
      required this.color_roof,
      required this.size_roof,
      required this.length_roof,
      required this.amount_roof,
      required this.cover_roof,
      required this.length_cover,
      required this.amount_cover,
      required this.orderitem_created,
      required this.orderitem_status});

  factory Orderalls.fromMap(Map<String, dynamic>? order) {
    if (order == null) {
      return Orderalls(
        id: null,
        typeroof: null,
        brand_roof: null,
        color_roof: null,
        size_roof: null,
        length_roof: null,
        amount_roof: null,
        cover_roof: null,
        length_cover: null,
        amount_cover: null,
        orderitem_created: null,
        orderitem_status: null,
      );
    }

    return Orderalls(
      id: order['id'],
      typeroof: order['typeroof'],
      brand_roof: order['brand_roof'],
      color_roof: order['color_roof'],
      size_roof: order['size_roof'],
      length_roof: order['length_roof'],
      amount_roof: order['amount_roof'],
      cover_roof: order['cover_roof'],
      length_cover: order['length_cover'],
      amount_cover: order['amount_cover'], 
      orderitem_created: order['orderitem_created'], 
      orderitem_status: order['orderitem_status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typeroof': typeroof,
      'brand_roof': brand_roof,
      'color_roof': color_roof,
      'size_roof': size_roof,
      'length_roof': length_roof,
      'amount_roof': amount_roof,
      'cover_roof': cover_roof,
      'length_cover': length_cover,
      'amount_cover': amount_cover,
      'orderitem_created':orderitem_created,
      'orderitem_status':orderitem_status
    };
  }
}
