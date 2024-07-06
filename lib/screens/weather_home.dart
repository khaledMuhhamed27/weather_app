import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_modern/model/weather_data.dart';
import 'package:flutter_application_modern/services/services.dart';
import 'package:intl/intl.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  WeatherData? weatherInfo;
  Timer? _timer;

  myWeather() {
    WeatherServices().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0.0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
    );
    myWeather();
    _startPeriodicUpdate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPeriodicUpdate() {
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      myWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formDate = DateFormat('EEEE d, MMM yyyy').format(DateTime.now());
    String formTime = DateFormat('hh:mm a').format(DateTime.now());
    return Scaffold(
      backgroundColor: Color(0xff676bd0),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: weatherInfo == null
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : WeatherDetail(
                      weather: weatherInfo!,
                      formattedDate: formDate,
                      formattedTime: formTime,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;

  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Text(
          weather.name,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(1)}°C",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (weather.weather.isNotEmpty)
          Text(
            "${weather.weather[0].main}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTime,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/cloudy.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wind_power,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            weatherInfoCard(
                                title: "Wind",
                                value: "${weather.wind.speed} km/h")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            weatherInfoCard(
                                title: "Max",
                                value:
                                    "${weather.maxTemperature.ceilToDouble()}°C")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            weatherInfoCard(
                                title: "Min",
                                value:
                                    "${weather.minTemperature.ceilToDouble()}°C")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Icon(
                              Icons.water_drop,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            weatherInfoCard(
                                title: "Humidity",
                                value: "${weather.humidity}%")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Icon(
                              Icons.air,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            weatherInfoCard(
                                title: "Pressure",
                                value: "${weather.pressure}hPa")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Icon(
                              Icons.leaderboard,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            weatherInfoCard(
                                title: "Sea-Level",
                                value: "${weather.seaLevel}m")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
