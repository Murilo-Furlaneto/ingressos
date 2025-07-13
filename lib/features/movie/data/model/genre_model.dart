import 'package:ingressos/features/movie/domain/entities/genre_entity.dart';

class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'], name: json['name']);
  }

 static Genre toEntity(GenreModel model){
    return Genre(model.id, model.name);
  }
}