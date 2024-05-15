import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favourite_widget.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  Set<String> favoriteCities = Set<String>();

  @override
  void initState() {
    super.initState();
    _loadFavoriteCities();
  }

  Future<void> _loadFavoriteCities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedCities = prefs.getStringList('favoriteCities');
      setState(() {
        favoriteCities = savedCities?.toSet() ?? Set<String>();
      });
    } catch (e) {
      print('Failed to load favorite cities: $e');
    }
  }

  Future<void> _removeFavoriteCity(String city) async {
    setState(() {
      favoriteCities.remove(city);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteCities', favoriteCities.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cities'),
      ),
      body: ListView.builder(
        itemCount: favoriteCities.length,
        itemBuilder: (context, index) {
          final city = favoriteCities.elementAt(index);
          return Card(
            child: ListTile(
              leading: Icon(Icons.location_city),
              title: Text(city),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeFavoriteCity(city);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherPage(city: city),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}