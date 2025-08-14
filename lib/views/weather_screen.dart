import 'package:flutter/material.dart';
import 'package:myweathersapp/controllers/weather_controller.dart';
import 'package:myweathersapp/models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherController _controller = WeatherController();

  WeatherModel? _weatherModel;

  String _errorMessage = "";

  void _getWeather() async {
    setState(() {
      _errorMessage = "";
      _weatherModel = null;
    });

    final weatherData = await _controller.fetchWeather(_cityController.text);

    if (weatherData != null) {
      setState(() {
        _weatherModel = weatherData;
      });
    } else {
      setState(() {
        _errorMessage = "City not found or API error";
      });
    }
  }

  void _clearData() {
    setState(() {
      _cityController.clear();
      _errorMessage = "";
      _weatherModel = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "Enter city name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: _getWeather,
                child: Text("Get Weather"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: _clearData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                child: Text("Clear"),
              ),
              SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(_errorMessage, style: TextStyle(color: Colors.red)),
              if (_weatherModel != null)
                Column(
                  children: [
                    Text(
                      "City: ${_weatherModel!.city} ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Temperature:${_weatherModel!.temperature} °C ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Weather: ${_weatherModel!.desc}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(" Humidity:${_weatherModel!.humid}"),
                    Text(" Visibility:${_weatherModel!.visibile}"),
                    Text("TimeZone: ${_weatherModel!.timez}"),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
