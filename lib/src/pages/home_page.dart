import 'package:peliculas/src/providers/pelicula_provider.dart';
import 'package:peliculas/src/widgets/card_swipper_widget.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart'; 


class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Peliculas"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
            )
          ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas(){
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return snapshot.hasData ? 
          CardSwiper(items: snapshot.data) : 
          Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
      },
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Populares", 
              style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(height: 5.0,),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return snapshot.hasData ?
                MovieHorizontal(peliculas: snapshot.data) :
                Center(child: CircularProgressIndicator());
            },
          ),
        ]
      ),
    );
  }
}