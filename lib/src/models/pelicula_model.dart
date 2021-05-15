class Peliculas {
  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null ) return;

    for(var item in jsonList){
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    this.adult = json["adult"];
    this.backdropPath = json["backdrop_path"];
    this.genreIds = json["genre_ids"].cast<int>();
    this.id = json["id"];
    this.originalLanguage = json["original_language"];
    this.originalTitle = json["original_title"];
    this.overview = json["overview"];
    this.popularity = json["popularity"] / 1;
    this.posterPath = json["poster_path"];
    this.releaseDate = json["release_date"];
    this.title = json["title"];
    this.video = json["video"];
    this.voteAverage = json["vote_average"] / 1;
    this.voteCount = json["vote_count"];
  }

  getPosterImg(){
      return this.posterPath == null ?
        "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg" :
        "https://image.tmdb.org/t/p/w500/${this.posterPath}";
  }

  getBackdropPath(){
    return this.backdropPath == null ? 
      "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg" :
      "https://image.tmdb.org/t/p/w500/${this.backdropPath}";
  }
}
