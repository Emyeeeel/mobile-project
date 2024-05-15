import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://api.unsplash.com';
  List<dynamic> allPhotos = [];
  List<dynamic> randomPhotos = [];

  Future<List<dynamic>> fetchPhotos() async {
    int page = 1;
    while (allPhotos.length < 100) {
      final response = await http.get(Uri.parse(
          '$_baseUrl/photos?per_page=50&page=$page&client_id=N__PKKjjE_rGt2fsn4xs_HXE0ajm7pLn5MJxUDMIHCk'));
      if (response.statusCode == 200) {
        final List<dynamic> photos = jsonDecode(response.body);
        allPhotos.addAll(photos);
        page++;
      } else {
        throw Exception('Failed to load photos');
      }
    }
    return allPhotos;
  }

  Future<List<dynamic>> searchPhoto(String query) async {
  int page = 1;
    allPhotos.clear(); 
    while (allPhotos.length < 50) {
      final response = await http.get(Uri.parse(
          '$_baseUrl/search/photos?per_page=50&page=$page&query=$query&client_id=N__PKKjjE_rGt2fsn4xs_HXE0ajm7pLn5MJxUDMIHCk'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> photos = responseData['results']; 
        allPhotos.addAll(photos);
        page++;
      } else {
        throw Exception('Failed to load photos');
      }
    }
    return allPhotos;
  }

  Future<List<dynamic>> getRandomPhotos() async {
    final response = await http.get(Uri.parse(
          '$_baseUrl/photos/random?count=20&orientation=portrait&client_id=N__PKKjjE_rGt2fsn4xs_HXE0ajm7pLn5MJxUDMIHCk'));
      if (response.statusCode == 200) {
        final List<dynamic> photos = jsonDecode(response.body);
        randomPhotos.addAll(photos);
      } else {
        throw Exception('Failed to load photos');
      }
    return randomPhotos;
  }
}