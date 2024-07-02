class WeatherInfo {
  final String description;
  final String icon;
  final String maindesc;

  WeatherInfo({
    required this.description,
    required this.icon,
    required this.maindesc,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    final maindesc = json['main'];
    return WeatherInfo(
        description: description, icon: icon, maindesc: maindesc);
  }
}

class TempInfo {
  final double temp;
  final int humidity;

  TempInfo({
    required this.temp,
    required this.humidity,
  });

  factory TempInfo.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'];
    final humidity = json['humidity'];
    return TempInfo(temp: temp, humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final TempInfo tempInfo;
  final WeatherInfo weatherInfo;
  final windSpeed;
  //final double humidity;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({
    required this.windSpeed,
    required this.cityName,
    required this.tempInfo,
    required this.weatherInfo,
    //required this.humidity,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TempInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final windSpeed = json['wind']['speed'];

    //final humidity = json['main']['humidity'];

    return WeatherResponse(
      cityName: cityName,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      windSpeed: windSpeed,
      //humidity: humidity
    );
  }
}
