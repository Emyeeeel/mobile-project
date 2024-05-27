import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_state.dart';
import '../models/photo_model.dart';

class ApiService {
  final String _baseUrl = 'https://api.unsplash.com';
  final String _clientId = 'N__PKKjjE_rGt2fsn4xs_HXE0ajm7pLn5MJxUDMIHCk';
  List<dynamic> allPhotos = [];

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
          '$_baseUrl/photos?per_page=50&page=$page&client_id=$_clientId'));
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

  Future<List<UnsplashPhoto>> getPhoto(List<String> topics) async {
    List<UnsplashPhoto> topicPhotos = [];
    try {
      for (String topic in topics) {
        final response = await http.get(Uri.parse(
            '$_baseUrl/photos/random?query=$topic&client_id=$_clientId'));
        if (response.statusCode == 200) {
          final dynamic responseData = jsonDecode(response.body);
          if (responseData is List<dynamic>) {
            final List<UnsplashPhoto> photos = responseData
                .map((json) => UnsplashPhoto.fromJson(json))
                .toList();
            topicPhotos.addAll(photos);
          } else if (responseData is Map<String, dynamic>) {
            final UnsplashPhoto photo = UnsplashPhoto.fromJson(responseData);
            topicPhotos.add(photo);
          } else {
            throw Exception('Unexpected response format');
          }
        } else {
          throw Exception('Failed to load photos');
        }
      }
      return topicPhotos;
    } catch (e) {
      print('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
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
}

class CountryStateCityRepo {
  static const countriesStateURL =
      'https://countriesnow.space/api/v0.1/countries/states';

  Future<CountryStateModel> getCountriesStates() async {
    try {
      var url = Uri.parse(countriesStateURL);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final CountryStateModel responseModel =
            countryStateModelFromJson(response.body);
        return responseModel;
      } else {
        return CountryStateModel(
            error: true,
            msg: 'Something went wrong: ${response.statusCode}',
            data: []);
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
