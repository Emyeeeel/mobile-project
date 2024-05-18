import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

class ApiService {
  final String _baseUrl = 'https://api.unsplash.com';
  final String _clientId = 'N__PKKjjE_rGt2fsn4xs_HXE0ajm7pLn5MJxUDMIHCk';

  Future<List<UnsplashPhoto>> getPhotosLandingPage() async {
    final response = await http.get(Uri.parse('$_baseUrl/photos/random?count=10&query=wallpaper&orientation=portrait&client_id=$_clientId'));
     if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => UnsplashPhoto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
  
  Future<List<UnsplashPhoto>> fetchPhotos() async {
    List<UnsplashPhoto> allPhotos = [];

    int page = 1;
    while (allPhotos.length < 100) {
      final response = await http.get(Uri.parse(
          '$_baseUrl/photos?per_page=50&page=$page&client_id=N__PKKjjE_rGt2fsn4xs_HXE0ajm7pLn5MJxUDMIHCk'));
      if (response.statusCode == 200) {
        final List<dynamic> photosData = jsonDecode(response.body);
        final List<UnsplashPhoto> photos =
            photosData.map((json) => UnsplashPhoto.fromJson(json)).toList();
        allPhotos.addAll(photos);
        page++;
      } else {
        throw Exception('Failed to load photos');
      }
    }
    return allPhotos;
  }
}
