import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/resources/weatherModel.dart';

class WeatherServices {
  //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  Future<WeatherResponse> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'appid': '47da02b01a29ec72245513893afc6ee1',
      'units': 'metric',
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);

    final json = jsonDecode(response.body);

    return WeatherResponse.fromJson(json);
  }
}
