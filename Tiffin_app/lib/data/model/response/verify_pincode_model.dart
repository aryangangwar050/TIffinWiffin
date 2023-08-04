class VerifyPincode {
  String message;
  String city;
  int id;

  VerifyPincode({this.message, this.city, this.id});

  VerifyPincode.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    city = json['city'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['city'] = this.city;
    data['id'] = this.id;
    return data;
  }
}