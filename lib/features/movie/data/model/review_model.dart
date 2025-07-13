import 'package:ingressos/features/movie/domain/entities/review_entity.dart';

class ReviewModel {
  final String author;
  final String content;

  ReviewModel({required this.author, required this.content});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      author: json['author'],
      content: json['content'],
    );
  }

  static Review toEntity(ReviewModel model){
    return Review(author: model.author, content: model.content);
  }
}