import 'package:flutter/material.dart';
import 'package:clima/Services/constants.dart';
import 'package:clima/Services/weather.dart';
import 'package:clima/Pages/city_page.dart';

class LocationPage extends StatefulWidget {
   var locationWeather ;
   LocationPage({this.locationWeather});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String cityName='';
  int temperature=0;
  String weatherIcon='';
  WeatherModel weather = WeatherModel();
  String weatherMessage ='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   update(widget.locationWeather);

  }

  void update(dynamic weatherData){

     setState(() {
       if(weatherData == null){
         temperature=0;
         cityName='';
         weatherMessage='unable to get the data';
         weatherIcon='error';
         return;
       }
       double temp= weatherData['main']['temp'];
       temperature = temp.toInt();
       cityName=weatherData['name'];
       var condition = weatherData['weather'][0]['id'];
       weatherIcon = weather.getWeatherIcon(condition);
       weatherMessage = weather.getMessage(temperature);
     });
      print(cityName);
      print(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async  {
                         var weatherData = await weather.getLocationWeather();
                         update(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.grey[800],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var enteredName = await Navigator.push(context, MaterialPageRoute(builder: (context)=> CityPage()));
                     if(enteredName != null){
                       var weatherData = await weather.getCityWeather(enteredName);
                       update(weatherData);
                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
