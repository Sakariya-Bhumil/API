import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class Second_example extends StatefulWidget {
  const Second_example({super.key});

  @override
  State<Second_example> createState() => _Second_exampleState();
}

class _Second_exampleState extends State<Second_example> {
  List<Photos> photolist = [];

  Future<List<Photos>> getphotos() async {
    final Response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(Response.body.toString());
    if (Response.statusCode == 200) {
      for (var i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photolist.add(photos);
      }
      return photolist;
    } else {
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getphotos(),
          builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
            return ListView.builder(
                itemCount: photolist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    title: Text(snapshot.data![index].id.toString()),
                    subtitle: Text(snapshot.data![index].title.toString()),
                  );
                });
          }),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
