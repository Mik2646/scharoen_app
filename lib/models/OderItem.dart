
class Orderitem {
  String? id;
  String? create_by;
  // DateTime? date;
  String? orderitem_status;

  Orderitem({
    required this.id,
    required this.create_by,
    // required this.date,
    required this.orderitem_status
  });

  factory Orderitem.fromMap(Map<String, dynamic>? oder_item) {
    if (oder_item == null) {
      return Orderitem(
        id: null,
        create_by: null,
        // date: null,
        orderitem_status: null,
      
      );
    }

    return Orderitem(
      id: oder_item['id'],
      create_by: oder_item['create_by'],
      // date: oder_item['date'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(oder_item['date'])
      //     : null,
      orderitem_status: oder_item['orderitem_status']
    
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'create_by': create_by,
      // 'date': date,
      'orderitem_status': orderitem_status,
    
    };
  }
}
