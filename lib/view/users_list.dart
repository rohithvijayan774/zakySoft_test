import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakysoft_test/controller/user_controller.dart';
import 'package:zakysoft_test/view/user_details.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context, listen: false);
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: FutureBuilder(
        future: controller.getUsers(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      height: 200,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF2A5470), Color(0xFF4C4177)]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.blueGrey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'ZakySoft',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Consumer<UserController>(
                                builder: (context, controller, _) {
                              return TextFormField(
                                onChanged: (value) {
                                  controller.searchUser(searchController.text);
                                },
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search User...',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Consumer<UserController>(
                            builder: (context, controller, _) {
                          return controller.results.isEmpty
                              ? const Center(
                                  child: Text('No user found!'),
                                )
                              : snapshot.connectionState == ConnectionState.none
                                  ? const Center(
                                      child: Text(
                                          'Oops... No Network Connection!!!'),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.results.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetails(
                                                        name: controller
                                                            .results[index]
                                                            .name,
                                                        username: controller
                                                            .results[index]
                                                            .username,
                                                        email: controller
                                                            .results[index]
                                                            .email,
                                                        address: controller
                                                            .results[index]
                                                            .address,
                                                        phone: controller
                                                            .results[index]
                                                            .phone,
                                                        website: controller
                                                            .results[index]
                                                            .website,
                                                        company: controller
                                                            .results[index]
                                                            .company),
                                              ));
                                            },
                                            title: Text(
                                              '${controller.results[index].name}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: const CircleAvatar(
                                              child: Icon(Icons.person),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                const Text(
                                                  'Company : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '${controller.results[index].company!.name}'),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
        },
      ),
    );
  }
}
