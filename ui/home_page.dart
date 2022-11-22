import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';
import 'package:catalogo_filmes/ui/movie_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //função para conectarmos a api e precisa ser assíncrona
  Future<Map> _getMovies() async {
    http.Response response;
      response = await http.get(
          Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=CHAVEAQUI&language=pt-BR&page=1"));

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          'TOP MOVIES by TMDB'
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Expanded(
            child: FutureBuilder(
                future: _getMovies(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createMovieTable(context, snapshot);
                  }
                }),
          ),
        ],
      ),
    );
  }

  int _getCount(List data){
      return data.length;
  }

  Widget _createMovieTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0),
        itemCount: _getCount(snapshot.data["results"]),
        itemBuilder: (context, index) {
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: "https://www.themoviedb.org/t/p/w220_and_h330_face" + snapshot.data["results"][index]["poster_path"],
                  height: 300.0,
                  fit: BoxFit.fitHeight),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MoviePage(snapshot.data["data"][index]))
                );
              },
            );
        });
  }
}
