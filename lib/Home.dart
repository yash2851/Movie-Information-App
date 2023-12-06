import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final movie;
  MovieCard(this.movie);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/detail');
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
