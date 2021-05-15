class Reparto{
  List<ActorModel> actores = [];
  
  Reparto();

  Reparto.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null ) return;

    for(var item in jsonList){
      final pelicula = ActorModel.fromJsonMap(item);
      actores.add(pelicula);
    }
  }
}

class ActorModel {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  ActorModel({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  ActorModel.fromJsonMap(Map<String, dynamic> json){
    this.adult = json["adult"];
    this.gender = json["gender"];
    this.id = json["id"];
    this.knownForDepartment = json["known_for_department"];
    this.name = json["name"];
    this.originalName = json["original_name"];
    this.popularity = json["popularity"];
    this.profilePath = json["profile_path"];
    this.castId = json["cast_id"];
    this.character = json["character"];
    this.creditId = json["credit_id"];
    this.order = json["order"];
  }

  getProfileImg(){
      return this.profilePath == null ?
        "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg" :
        "https://image.tmdb.org/t/p/w500/${this.profilePath}";
  }
}
