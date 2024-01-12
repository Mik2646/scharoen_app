class Orderitem {
  String? id;
  String? create_by;
  String? dates;
  String? orderitem_status;
  String? image;

  Orderitem(
      {required this.id,
      required this.create_by,
      required this.dates,
      required this.orderitem_status,
      required this.image});

  factory Orderitem.fromMap(Map<String, dynamic>? oder_item) {
    if (oder_item == null) {
      return Orderitem(
        id: null,
        create_by: null,
        dates: null,
        orderitem_status: null,
        image:null
      );
    }

    return Orderitem(
        id: oder_item['id'],
        create_by: oder_item['create_by'],
        dates: oder_item['date'],
        //     ? DateTime.fromMillisecondsSinceEpoch(oder_item['date'])
        //     : null,
        image:oder_item['image'],
        orderitem_status: oder_item['orderitem_status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'create_by': create_by,
      'date': dates,
      'orderitem_status': orderitem_status,
      'image':image
    };
  }
}
