class Order {
  Order(this.id, this.orderTimestamp, this.paymentType, this.status, this.cost,
      this.storeLocation, this.customerLocation, this.username, this.rideId);
  Order.empty();

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      int.parse(json['id'].toString()),
      DateTime.parse(json['orderTimestamp'].toString()),
      json['paymentType'],
      json['status'],
      double.parse(json['cost'].toString()),
      json['location'],
      json['customerLocation'],
      json['username'],
      json['rideId'],
    );
  }

  int id = -99;
  DateTime orderTimestamp = DateTime.now();
  String paymentType = '';
  String status = '';
  double cost = 0;
  String storeLocation = '';
  String customerLocation = '';
  String customerId = '';
  String username = '';
  String rideId = '';
}
