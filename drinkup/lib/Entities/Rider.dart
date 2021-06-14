class Rider {
  Rider(this.username, this.email, this.password, this.phonenumber,
      this.vehiclePlate);
  Rider.allData(this.username, this.email, this.password, this.phonenumber,
      this.vehiclePlate, this.city);
  Rider.loginData(this.email, this.password);

  String username = '';
  String email;
  String password;
  String phonenumber = '';
  String vehiclePlate = '';
  String city = '';
}
