import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myweathersapp/models/weather_model.dart';

class WeatherController {
  final String apiKey = "5f45bc43ba5e89968666eda2a0cf3b3b";
  Future<WeatherModel?> fetchWeather(String cityName) async {
    if (cityName.isEmpty) return null;

    final url =
        "http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response);
        print(data);
        return WeatherModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
