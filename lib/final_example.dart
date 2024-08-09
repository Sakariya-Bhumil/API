import 'dart:convert';

import 'package:api/models/Final_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Final_example extends StatefulWidget {
  const Final_example({super.key});

  @override
  State<Final_example> createState() => _Final_exampleState();
}

class _Final_exampleState extends State<Final_example> {
  Future<Finalmodel?> getdatafinalapi() async {
    final responce = await http.get(
        Uri.parse('https://webhook.site/69a650b0-5e21-493a-a1b1-bb61da98cb25'));
    var Data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      return Finalmodel.fromJson(Data);
    } else {
      return Finalmodel.fromJson(Data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Finalmodel?>(
          future: getdatafinalapi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .3,
                          width: MediaQuery.of(context).size.width * .5,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data!.data![index].images!.length,
                              itemBuilder: (context, possition) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * 1,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data![index]
                                              .images![possition]
                                              .url
                                              .toString()))),
                                );
                              }),
                        )
                      ],
                    );
                  });
            } else {
              return Text("Loading");
            }
          }),
    );
  }
}
