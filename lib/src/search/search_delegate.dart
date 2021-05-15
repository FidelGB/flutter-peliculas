import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate{

  final peliculasProvider = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = "";
        }
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando se escribe

    return query.isEmpty ?
           Container() :
           FutureBuilder(
             future: peliculasProvider.buscarPelicula(query),
             builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) => snapshot.hasData ?
              ListView(
                children: snapshot.data.map((pelicula){
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage(pelicula.getPosterImg()),
                      placeholder: AssetImage("assets/img/no-image.jpg"),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: (){
                      close(context, null);
                      pelicula.uniqueId = "";
                      Navigator.pushNamed(context, "detalle", arguments: pelicula);
                    },
                  );
                }).toList()
              ) : 
              Center(
                child: CircularProgressIndicator(),
              )
           );
  }
}