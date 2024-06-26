import 'package:flutter/material.dart';
import 'package:weather/api/conclusion.dart';
import 'package:weather/api/api_Requests.dart';
import '../../api/Apiweek.dart';
import '../home/home_widget.dart'; // Assuming you have an API requests file

class WeatherPage extends StatefulWidget {
  final String city;

  WeatherPage({required this.city});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Autogenerated? response;
  Apiweek? weeklyResponse;
  bool inProgress = false;
  bool showWeeklyForecast = false;
  bool isCurrentCityFavorite = false;
  String currentCity = '';
  Set<String> favoriteCities = Set<String>();

  @override
  void initState() {
    super.initState();
    _getWeatherData(widget.city);
  }
  @override
  Widget build(BuildContext context) {

    var currentWeather = response?.current;
    if (currentWeather == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(), // This line adds the loading animation
        ),
      );
    }

      return Scaffold(
        appBar: AppBar(
          title: Text('Weather in ${response?.location?.name}'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (inProgress)
                CircularProgressIndicator()
              else if (showWeeklyForecast)
                _buildWeeklyForecastWidget()
              else
                Expanded(child: SingleChildScrollView(child: WeatherWidget(response: response))),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: _buildShowWeeklyForecastButton(),
        ),
      );

  }

  Widget _buildShowWeeklyForecastButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Добавляем отступ сверху
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellowAccent, // Фиолетовый цвет кнопки
        ),
        onPressed: () {
          if (response != null) {
            if (showWeeklyForecast) {
              _getWeatherData(response!.location!.name!);
            } else {
              _getWeeklyForecast(response!.location!.name!);
            }
            setState(() {
              showWeeklyForecast = !showWeeklyForecast; // Обновляем showWeeklyForecast
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.5),
          child: Text(showWeeklyForecast ? 'Погода на неделю' : 'Погода сейчас',
            style: TextStyle(color: Colors.black),),
        ),
      ),
    );
  }

  Future<void> _getWeatherData(String location) async {
    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      print('Exception: $e');
    }
    setState(() {}); // Trigger a rebuild with the new weather data
  }

  _getWeeklyForecast(String location) async {
    setState(() {
      inProgress = true;
      weeklyResponse = null; // Сбрасываем weeklyResponse перед запросом
    });

    try {
      final response = await WeatherApi().getWeeklyForecast(location);
      setState(() {
        weeklyResponse = response;
      });
    } catch (e) {
      print('Exception: $e');
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  Widget _buildWeeklyForecastWidget() {
    if (weeklyResponse == null) {
      return const Text(
        'No weekly forecast available',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Увеличиваем размер текста и делаем его полужирным
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: weeklyResponse!.forecast!.forecastday!.length,
      itemBuilder: (context, index) {
        final forecastDay = weeklyResponse!.forecast!.forecastday![index];
        return Card(
          child: ListTile(
            title: Text(
              forecastDay.date!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Увеличиваем размер текста и делаем его полужирным
            ),
            subtitle: Text(
              'Max Temp: ${forecastDay.day!.maxtempC.toString()}°C',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Увеличиваем размер текста и делаем его полужирным
            ),
            trailing: Text(
              'Min Temp: ${forecastDay.day!.mintempC.toString()}°C',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Увеличиваем размер текста и делаем его полужирным
            ),
          ),
        );
      },
    );
  }
}

