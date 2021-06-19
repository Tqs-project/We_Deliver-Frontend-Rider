class Rider {
  Rider(
    this.username,
    this.email,
    this.password,
    this.phonenumber,
    this.vehiclePlate,
  );
  Rider.allData(this.username, this.email, this.password, this.phonenumber,
      this.vehiclePlate, this.city);
  Rider.loginData(this.username, this.password);
  Rider.json(
      this.id, this.username, this.email, this.phonenumber, this.vehiclePlate);
  Rider.empty();
  factory Rider.fromJson(Map<String, dynamic> json) {
    if (int.parse(json['id'].toString()) == null) {
      return Rider.empty();
    }
    return Rider.json(
      int.parse(json['id'].toString()),
      json['username'],
      json['email'],
      json['phoneNumber'],
      json['vehiclePlate'],
    );
  }

  int id = 0;
  String username = '';
  String email = '';
  String password = '';
  String phonenumber = '';
  String vehiclePlate = '';
  String city = '';
}
