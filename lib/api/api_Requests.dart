import 'dart:convert';

import 'package:weather/api/Key.dart';
import 'package:http/http.dart' as http;

import 'conclusion.dart';

class WeatherApi{
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";


  Future<Autogenerated> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return Autogenerated.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      print('Exception: $e'); // Add this line
      throw Exception("Failed to load weather");
    }
  }
}