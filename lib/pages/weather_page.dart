import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_model.dart';
import 'package:my_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage ({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{

  //api key
  final _weatherService = WeatherService("393b32bc77f19cada3e9281ce0e1ec12");
  WeatherModel? _weather;

  //fetch the weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get the weather for the city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch(e){
      print(e);
    }
  }

  //weather animations

  //init state
  @override
  void initState(){
    super.initState();

    //fetch the weather on startup
    _fetchWeather();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cit name
            Text(_weather?.cityName ?? "loading city..."),


            //tempreature
            Text('${_weather?.temperature.round()}*C'),
          ],
        ),
    ));
  }
}
