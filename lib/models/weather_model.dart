class WeatherModel {
  final String city;
  final double temperature;
  final String desc;
  final double humid;
  final double visibile;
  final int timez;

  WeatherModel({
    required this.city,
    required this.desc,
    required this.temperature,
    required this.humid,
    required this.visibile,
    required this.timez,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      desc: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humid: json['main']['humidity'],
      visibile: json['visibility'],
      timez: json['timezone'],
    );
  }
}
