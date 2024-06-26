import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/photo_model.dart';

import '../services/api_services.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final landingPagePhotosProvider = FutureProvider<List<UnsplashPhoto>>((ref) async {
  final service = ApiService();
  return service.getPhotosLandingPage();
});

final homePagePhotosProvider = FutureProvider<List<UnsplashPhoto>>((ref) async {
  final service = ApiService();
  return service.fetchPhotos();
});

final photoProvider = FutureProvider<List<UnsplashPhoto>>((ref) async {
  final service = ApiService();
  return service.fetchPhotos();
});

final topicPhotosProvider = FutureProvider.family<List<UnsplashPhoto>, List<String>>((ref, topics) async {
  final service = ref.read(apiServiceProvider);
  return service.getPhoto(topics);
});

final searchPhotoProvider = FutureProvider.family<List<dynamic>, String>((ref, query) async {
  final service = ApiService();
  return service.searchPhoto(query);
});



