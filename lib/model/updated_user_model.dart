import 'package:zakysoft_test/model/user_model.dart';

class UpdatedUserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  UpdatedUserModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

       UpdatedUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];

    address = Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: Geo(
        lat: json['lat'],
        lng: json['lng'],
      ),
    );

    phone = json['phone'];
    website = json['website'];

    company = Company(
      name: json['companyName'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}
