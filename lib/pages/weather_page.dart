import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState()=>_WeatherPageState();
}
class _WeatherPageState extends State<WeatherPage>{
  

  final _WeatherService=WeatherService('f70b321918ba254c9294bec8e40b4d05');
  Weather?_Weather;
  _fetchWeather()async{

    String cityName=await _WeatherService.getCurrentCity();
    try{
      final weather= await _WeatherService.getWeather(cityName);
      setState(() {
        _Weather=weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
if(mainCondition==null) return 'assets/sun.json';
switch (mainCondition.toLowerCase()) {
  case 'rain':
  return'assets/rain.json';
      case 'cloud':
  return'assets/cloud.json';
    
    break;
    default:
      return'assets/cloud.json';

}

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }
  @override
  
    Widget build(BuildContext context) {
return Scaffold(
body: Center(
  child: Column(
    
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(_Weather?.cityName ??'loading city..'),
      Lottie.asset(getWeatherAnimation(_Weather?.mainCondition)),
      Text('${_Weather?.temperature.round()}C'),
         Text(_Weather?.mainCondition ??'  '),
    ],
  ),
),);
  }

}