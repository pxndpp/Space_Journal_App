import 'dart:convert'; // ไว้แปลง JSON
import 'package:http/http.dart' as http; // package ไว้ต่อเน็ต 
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_space_story/models/apod_entry.dart';

class ApiService {
  static const String _baseURL = 'https://api.nasa.gov/planetary/apod';
  static final String _apiKEY = dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY';

  Future<ApodEntry?> fetchData ({String? date}) async {
    try {
        String urlString = '$_baseURL?api_key=$_apiKEY';
        if (date != null) {
        urlString += '&date=$date';} // YYYY-MM-DD

        final Uri url = Uri.parse(urlString);
        final http.Response response = await http.get(url);

        // (Status Code 200 คือ ปกติ)
        if (response.statusCode == 200) {
        // แปลง JSON เป็น Map
          final Map<String, dynamic> jsonData = json.decode(response.body);
          return ApodEntry.fromJson(jsonData);
        } 
        else {
          throw Exception('Failed to load : ${response.statusCode}');
        } 
      } catch (e){
          print('Something wrong : $e');
          throw Exception('Check internet connection');
        }
  }
}