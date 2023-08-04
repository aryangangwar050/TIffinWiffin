class SignUpModel {
  String fName;
  String lName;
  String address;
  String phone;
  String email;
  String password;

  SignUpModel(
      {this.fName,
      this.lName,
      this.address,
      this.phone,
      this.email = '',
      this.password});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
