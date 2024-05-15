import 'package:meta/meta.dart'; 

@immutable
class UnsplashPhoto {
  final String id;
  final String photoUrl;
  final String photographerUsername;
  final String photographerProfileImageUrl;
  final int likes;
  final String description;
  final List<String> topics;

  const UnsplashPhoto({
    required this.id,
    required this.photoUrl,
    required this.photographerUsername,
    required this.photographerProfileImageUrl,
    required this.likes,
    required this.description,
    required this.topics,
  });

  factory UnsplashPhoto.fromJson(Map<String, dynamic> json) {
    final url = json['urls'];
    final user = json['user'];
    final topicSubmissions = json['topic_submissions'];

    final topics = topicSubmissions != null
        ? topicSubmissions.keys.toList()
        : []; 

    return UnsplashPhoto(
      id: json['id'] ?? '',
      photoUrl: url['regular'] ?? '',
      photographerUsername: user['username'] ?? '',
      photographerProfileImageUrl: user['profile_image']['medium'] ?? '',
      likes: json['likes'] ?? 0,
      description: json['description'] ?? '',
      topics: topics,
    );
  }
}