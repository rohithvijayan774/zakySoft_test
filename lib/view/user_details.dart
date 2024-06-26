import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakysoft_test/controller/user_controller.dart';
import 'package:zakysoft_test/model/user_model.dart';

class UserDetails extends StatelessWidget {
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;
  const UserDetails(
      {super.key,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 30,
            ),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                  image: AssetImage('assets/image_error.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton.filled(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_file_outlined),
                    title: Text(
                      username!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_email_outlined),
                    title: Text(
                      email!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_sharp),
                    title: Text(
                      '${address!.suite}, ${address!.street},\n${address!.city} - ${address!.zipcode}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: Text(
                      phone!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.blur_on_outlined),
                    title: Text(
                      website!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.business),
                    title: Text(
                      company!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      "${company!.catchPhrase!}\n${company!.bs}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.launchGoogleMap(double.parse(address!.geo!.lat!),
              double.parse(address!.geo!.lng!));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.directions_outlined),
      ),
    );
  }
}
