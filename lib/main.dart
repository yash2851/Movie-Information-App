import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MovieHub',
        debugShowCheckedModeBanner: false,
        routes: {'/': (context) => Home(), '/detail': (context) => Detail()});
  }
}

Future<Map> getJson() async {
  http.Response response = await http.get(Uri.parse(
      'http://api.themoviedb.org/3/discover/movie?api_key=20a3f47c1f9a22b518bf93d335169cca'));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MovieHub',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Trending",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          MovieList(),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var movies; // Add this

  Future<void> getData() async {
    //Add this function
    try {
      var data = await getJson();
      setState(() {
        movies = data['results'];
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Expanded(
      child: ListView.builder(
          itemCount: movies == null ? 0 : movies.length,
          itemBuilder: (context, i) => MovieCard(movies[i])),
    );
  }
}

class MovieCard extends StatefulWidget {
  final movie;
  MovieCard(this.movie);
  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  // Add this
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/detail',
                arguments: {'movie': widget.movie});
          },
          child: Row(
            children: <Widget>[
              Container(
                  height: 180,
                  child: Image.network(
                      'https://image.tmdb.org/t/p/w500/${widget.movie['poster_path']}')),
              Expanded(
                child: Ink(
                  height: 180,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.movie['title'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Expanded(child: Text(widget.movie['overview']))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
