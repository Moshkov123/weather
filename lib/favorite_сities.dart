import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCitiesManager {
  static const String _favoriteCitiesKey = 'favoriteCities';

  static Future<Set<String>> loadFavoriteCities() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedCities = prefs.getStringList(_favoriteCitiesKey);
    return savedCities?.toSet() ?? Set<String>();
  }

  static Future<void> saveFavoriteCities(Set<String> favoriteCities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteCitiesKey, favoriteCities.toList());
  }

  static Future<bool> toggleFavoriteCity(String city) async {
    final favoriteCities = await loadFavoriteCities();
    bool isFavorite;
    if (favoriteCities.contains(city)) {
      favoriteCities.remove(city);
      isFavorite = false;
    } else {
      favoriteCities.add(city);
      isFavorite = true;
    }
    await saveFavoriteCities(favoriteCities);
    return isFavorite;
  }
}