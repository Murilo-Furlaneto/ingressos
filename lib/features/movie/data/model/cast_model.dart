import 'package:ingressos/features/movie/domain/entities/cast_entity.dart';

class CastModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'] ?? '',
    );
  }

  static Cast toEntity(CastModel model){
    return Cast(id: model.id,
     name: model.name, 
     character: model.character,
      profilePath: model.profilePath,
      );
  }
}