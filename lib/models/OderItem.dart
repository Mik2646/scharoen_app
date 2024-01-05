
class Orderitem {
  String? id;
  String? employee_id;
  String? order_id;
  DateTime? orderitem_created;
  String? orderitem_status;

  Orderitem({
    required this.id,
    required this.employee_id,
    required this.order_id,
    required this.orderitem_created,
    required this.orderitem_status
  });

  factory Orderitem.fromMap(Map<String, dynamic>? oder_item) {
    if (oder_item == null) {
      return Orderitem(
        id: null,
        employee_id: null,
        order_id: null,
        orderitem_created: null,
        orderitem_status: null,
      
      );
    }

    return Orderitem(
      id: oder_item['id'],
      employee_id: oder_item['employee_id'],
      order_id: oder_item['order_id'],
      orderitem_created: oder_item['orderitem_created'],
      orderitem_status: oder_item['orderitem_status']
    
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employee_id,
      'order_id': order_id,
      'orderitem_created': orderitem_created,
      'orderitem_status': orderitem_status,
    
    };
  }
}
