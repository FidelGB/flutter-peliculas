import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                _posterTitulo(pelicula, context),
                _descripcion(pelicula),
                _crearCasting(pelicula)
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _crearAppBar(Pelicula pelicula){
    return SliverAppBar(
       elevation: 2.0,
       backgroundColor: Colors.red,
       expandedHeight: 200.0,
       floating: false,
       pinned: true,
       flexibleSpace: FlexibleSpaceBar(
         centerTitle: true,
         title: Text(
           pelicula.title,
           style: TextStyle(
             fontSize: 16.0
           ),
         ),
         background: FadeInImage(
           image: NetworkImage(pelicula.getBackdropPath()),
           placeholder: AssetImage("assets/img/loading.gif"),
           fit: BoxFit.cover,
         ),
       ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0
      ),
      child: Text(
        pelicula.overview   ,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula){
    final peliProvider = PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot<List<ActorModel>> snapshot) {
        return snapshot.hasData ? 
          _crearActoresPageView(snapshot.data, context) :
          Center(
            child: CircularProgressIndicator()
          );
      },
    );
  }

  Widget _crearActoresPageView(List<ActorModel> actores, BuildContext context){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (BuildContext context, int i){
          return _actorTarjeta(actores[i], context);
        },
      ),
    );
  }

  Widget _actorTarjeta(ActorModel actor, BuildContext context) => Container(
    child: Column(
      
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
            placeholder: AssetImage("assets/img/no-image.jpg"),
            image: NetworkImage(actor.getProfileImg()),
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    ),
  );
}