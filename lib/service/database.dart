import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scharoen_app/models/Orderall.dart';
import 'package:scharoen_app/models/OderItem.dart';
import 'package:scharoen_app/models/Employee.dart';

class Database {
  static Database instance = Database._();
  Database._();
  Stream<List<Orderalls>> getorderall() {
    final reference = FirebaseFirestore.instance.collection('order');
    Query query = reference.orderBy('id', descending: true);
    final Snapshot = query.snapshots();
    return Snapshot.map((Snapshot) {
      return Snapshot.docs.map((doc) {
        return Orderalls.fromMap(doc.data() as Map<String, dynamic>?);
      }).toList();
    });
  }
}
class Orderitems{
  static Orderitems instance = Orderitems._();
  Orderitems._();

  Stream<List<Orderitem>> getOrderitem() {
    final reference = FirebaseFirestore.instance.collection('oder_item');

  Query query = reference.orderBy('id', descending: true);

    final Snapshot = query.snapshots();

    return Snapshot.map((Snapshot) {
      return Snapshot.docs.map((doc) {
        return Orderitem.fromMap(doc.data() as Map<String, dynamic>?);
      }).toList();
    });
  }
}

class Ordermanufacture {
  static Ordermanufacture instance = Ordermanufacture._();
  Ordermanufacture._();

  Stream<List<Orderitem>> getordermanufacture() {
    final reference = FirebaseFirestore.instance.collection('oder_item');

    Query query = reference.where('orderitem_status', whereIn: ['pending']);

    final Snapshot = query.snapshots();

    return Snapshot.map((Snapshot) {
      return Snapshot.docs.map((doc) {
        return Orderitem.fromMap(doc.data() as Map<String, dynamic>?);
      }).toList();
    });
  }
}

class Employeeall {
  static Employeeall instance = Employeeall._();
  Employeeall._();
  Stream<List<Employee>> getEmployeeall() {
    final reference = FirebaseFirestore.instance.collection('employee');
    Query query = reference.orderBy('status', descending: true);
    final Snapshot = query.snapshots();
    return Snapshot.map((Snapshot) {
      return Snapshot.docs.map((doc) {
        return Employee.fromMap(doc.data() as Map<String, dynamic>?);
      }).toList();
    });
  }
}

class orderitem {
  static orderitem instance = orderitem._();
  orderitem._();
  Stream<List<Orderitem>> getorderall() {
    final reference = FirebaseFirestore.instance.collection('order_item');
    final Snapshot = reference.snapshots();
    return Snapshot.map((Snapshot) {
      return Snapshot.docs.map((doc) {
        return Orderitem.fromMap(doc.data());
      }).toList();
    });
  }
}

class addorder {
  Future<void> setorder({required Orderalls order}) async {
    final reference = FirebaseFirestore.instance.doc('order/${order.id}');
    try {
      await reference.set(order.toMap());
    } catch (err) {
      rethrow;
    }
  }
}

class orderdelete {
  Future<void> deleteorder({required Orderalls order}) async {
    final reference = FirebaseFirestore.instance.doc('order/${order.id}');
    try {
      await reference.delete();
    } catch (err) {
      rethrow;
    }
  }
}

class addEmployee {
  Future<void> adduser({required Orderalls order}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('employee')
        .orderBy('datetime', descending: true)
        .get();
    ;
    var Id, count;
    if (snapshot.docs.isEmpty) {
      Id = "202401";
      count = 01;
    } else {
      count = snapshot.docs.first['count'] + 1;
      Id = '2024$count';
    }
    await FirebaseFirestore.instance.collection('employee').doc(Id).set(
        {'count': count, 'data': 'data', 'datetime': DateTime.now(), 'id': Id});
  }
}
