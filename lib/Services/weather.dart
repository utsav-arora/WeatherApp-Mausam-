import 'dart:convert';

import 'package:clima/Services/location.dart';
import 'package:clima/Services/data.dart';
import 'package:http/http.dart' as http ;

class WeatherModel{

  Future<dynamic> getCityWeather(String cityName) async {
    var response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=6b232833b4db8996d01dd4b30d48a522&units=metric'));


    if(response.statusCode == 200){

      var jsonData = jsonDecode(response.body);
      return jsonData;

    }
    else{
      print(response.statusCode);
    }

  }

  Future<dynamic> getLocationWeather() async{
    Location location = new Location();

    await location.getCurrentLocation();

    Data data =Data();
    var weatherData = await data.getData(location.latitude, location.longitude);
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}