import 'package:flutter/material.dart';
import 'package:webservice/Album.dart';
import 'Album.dart';

class Detalle extends StatelessWidget {
  Album nombreAlbum;

  Detalle({required this.nombreAlbum});



  @override
  Widget build(BuildContext context) {
return MaterialApp(
  home: Scaffold (
    appBar: AppBar(
      title: Text("Detalle"),
    ),
    body: Column(
      children: [
        Text(nombreAlbum.title),
      ],
    ),
  ),
);
  }

}