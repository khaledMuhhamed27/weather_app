import 'dart:convert';
import 'package:flutter_application_modern/model/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  Future<WeatherData> fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=41.01384&lon=28.94966&appid=242add1b0d570d0ecd51fe4702d3937e"),
    );
    try {
      if (response.statusCode == 200) {
        // تعديل هنا
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather Data');
      }
    } catch (e) {
      print(e);
      rethrow; // تعديل لإعادة الخطأ للتعامل معه في مكان آخر إذا لزم الأمر
    }
  }
}
