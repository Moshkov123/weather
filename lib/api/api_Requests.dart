import 'dart:convert';

import 'package:weather/api/Key.dart';
import 'package:http/http.dart' as http;

import 'Apiweek.dart';
import 'conclusion.dart';

class WeatherApi {
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
      throw Exception("Failed to load weather");
    }
  }
  Future<Apiweek> getWeeklyForecast(String location) async {

    String apiUrl =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$location&days=7&hour=13&aqi=no&alerts=no";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return Apiweek.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw Exception("Failed to load weather");
    }
  }
}
