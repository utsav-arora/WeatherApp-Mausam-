import 'package:flutter/material.dart';
import 'package:clima/Services/weather.dart';
import 'package:clima/Pages/location_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  String message ='location';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();
  }


 void getLocation() async{

    WeatherModel weather = WeatherModel();
    var weatherData = await weather.getLocationWeather();

     Navigator.push(context, MaterialPageRoute(builder: (Context)=>LocationPage(
       locationWeather: weatherData,
     )));
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
