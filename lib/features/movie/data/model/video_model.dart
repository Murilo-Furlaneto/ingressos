import 'package:ingressos/features/movie/domain/entities/video_entity.dart';

class VideoModel {
  final String key;
  final String site;
  final String type;

  VideoModel({required this.key, required this.site, required this.type});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      key: json['key'],
      site: json['site'],
      type: json['type'],
    );
  }

  static Video toEntity(VideoModel model){
    return Video(
      key: model.key,
      site: model.site,
      type: model.key,
    );
  }
}