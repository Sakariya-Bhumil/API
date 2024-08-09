import 'dart:convert';

import 'package:api/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Third_example extends StatefulWidget {
  const Third_example({super.key});

  @override
  State<Third_example> createState() => _Third_exampleState();
}

class _Third_exampleState extends State<Third_example> {
  List<Usermodel> UserList = [];
  Future<List<Usermodel>> getuserapi() async {
    final Response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var Data = jsonDecode(Response.body.toString());
    if (Response.statusCode == 200) {
      for (var i in Data) {
        UserList.add(Usermodel.fromJson(i));
      }
      return UserList;
    } else {
      return UserList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: FutureBuilder(
            future: getuserapi(),
            builder: (context, AsyncSnapshot<List<Usermodel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: UserList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index].name.toString()),
                                  Text(
                                      snapshot.data![index].username.toString())
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index].email.toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index].address!.suite
                                      .toString()),
                                  Text(snapshot.data![index].address!.geo!.lat
                                      .toString())
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
