import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/utils/colors.dart';
import 'package:weatherapp/resources/weatherModel.dart';
import 'package:weatherapp/resources/weatherServices.dart';
import 'package:weatherapp/widgets/weatherInfoContainer.dart';

class WeatherDetailScreen extends StatefulWidget {
  final WeatherResponse weatherResponse;

  const WeatherDetailScreen({
    super.key,
    required this.weatherResponse,
  });

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late WeatherResponse _weatherResponse;
  final _weatherServices = WeatherServices();

  @override
  void initState() {
    super.initState();
    _weatherResponse = widget.weatherResponse;
  }

  Future<void> _refreshWeather() async {
    final response =
        await _weatherServices.getWeather(_weatherResponse.cityName);
    setState(() {
      _weatherResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDateTime = DateFormat('dd-MM-yyyy hh:mm a').format(now);

    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          _weatherResponse.cityName,
          style: TextStyle(
            color: whiteColor,
            fontSize: isTablet ? 28 : 18,
          ),
        ),
        iconTheme: const IconThemeData(
          color: whiteColor,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isTablet ? 32 : 0),
            child: IconButton(
              icon: const Icon(
                Icons.refresh,
              ),
              onPressed: _refreshWeather,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/wp.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 50.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current weather",
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 16,
                      color: whiteColor.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    currentDateTime,
                    style: TextStyle(
                      fontSize: isTablet ? 28 : 16,
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _weatherResponse.cityName,
                    style: TextStyle(
                      fontSize: isTablet ? 60 : 44,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(height: 50),

                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _weatherResponse.tempInfo.temp.toString(),
                              style: TextStyle(
                                fontSize: isTablet ? 100 : 76,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                            Text(
                              "°C",
                              style: TextStyle(
                                fontSize: isTablet ? 28 : 24,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),

                        Image.network(
                          _weatherResponse.iconUrl,
                        ),

                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _weatherResponse.weatherInfo.description,
                        style: TextStyle(
                          fontSize: isTablet ? 32 : 16,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),

                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherInfoContainer(
                          description: 'Wind speed',
                          data: _weatherResponse.windSpeed.toString(),
                          icon: Icon(
                            WeatherIcons.windy,
                            size: isTablet ? 55 : 35,
                            color: whiteColor,
                          ),
                        ),
                        WeatherInfoContainer(
                          description: 'Humidity',
                          data: _weatherResponse.tempInfo.humidity.toString(),
                          icon: Icon(
                            WeatherIcons.humidity,
                            size: isTablet ? 55 : 35,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
