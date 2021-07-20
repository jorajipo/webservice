import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webservice/Album.dart';
import 'package:webservice/Detalle.dart';

Future<List<Album>> fetchAlbum() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

   return (json.decode(response.body) as List)
        .map((data) => Album.fromJson(data))
        .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Late significa que se inicializará más tarde
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbums,
            builder: (context, snapshot) {
              List<Album> lista = snapshot.data!;
              //Se verifica que tenga datos y no sea un nulo
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading:Icon( Icons.account_circle_rounded),
                      title: Text(snapshot.data![index].title),
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute
                          (builder: (context) => Detalle(nombreAlbum: snapshot.data![index]),
                        ),
                        );
                      },
                    );
                  },
                );

              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}