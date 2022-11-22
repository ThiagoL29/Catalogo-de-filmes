import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {

  final Map _movieData; //qual gif será apresentado

  MoviePage(this._movieData); //construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_movieData["title"]),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
            }, )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_movieData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}

