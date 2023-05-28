import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/components/weather_item.dart';
import 'package:weatherapp/models/constants.dart';

class DetailPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dailyForecastWeather;

  const DetailPage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          // ignore: prefer_interpolation_to_compose_strings
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        "maxWindSpeed": maxWindSpeed,
        "avgHumidity": avgHumidity,
        "chanceOfRain": chanceOfRain,
        "forecastDate": forecastDate,
        "weatherName": weatherName,
        "weatherIcon": weatherIcon,
        "minTemperature": minTemperature,
        "maxTemperature": maxTemperature,
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: _constants.backgroundColor,
      appBar: AppBar(
        title: const Text('Forecasts', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .80,
              width: size.width,
              decoration: BoxDecoration(
                color: _constants.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -30,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 280,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        color: _constants.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: _constants.primaryColor.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'assets/' +
                                      getForecastWeather(0)["weatherIcon"],
                                  width: 150),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                width: size.width * .8,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    WeatherItem(
                                      value:
                                          getForecastWeather(0)["maxWindSpeed"],
                                      unit: "km/h",
                                      imageUrl: "assets/windspeed.png",
                                    ),
                                    WeatherItem(
                                      value:
                                          getForecastWeather(0)["avgHumidity"],
                                      unit: "%",
                                      imageUrl: "assets/humidity.png",
                                    ),
                                    WeatherItem(
                                      value:
                                          getForecastWeather(0)["chanceOfRain"],
                                      unit: "%",
                                      imageUrl: "assets/lightrain.png",
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: _constants.secundaryColor,
                                  ),
                                ),
                                Text(
                                  '°',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: _constants.secundaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 300,
                            child: SizedBox(
                              height: 420,
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Card(
                                    color: _constants.primaryColor,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    0)["forecastDate"],
                                                style: GoogleFonts.mukta(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mukta(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        "°",
                                                        style: GoogleFonts.mukta(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium,
                                                            color: Colors.white,
                                                            fontSize: 30,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mukta(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        "°",
                                                        style: GoogleFonts.mukta(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium,
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/' +
                                                        getForecastWeather(
                                                            0)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        1)["weatherName"],
                                                    style: GoogleFonts.mukta(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    getForecastWeather(0)[
                                                                "chanceOfRain"]
                                                            .toString() +
                                                        "%",
                                                    style: GoogleFonts.mukta(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                      color:
                                                          _constants.greyColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: _constants.primaryColor,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    1)["forecastDate"],
                                                style: GoogleFonts.mukta(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mukta(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        "°",
                                                        style: GoogleFonts.mukta(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium,
                                                            color: Colors.white,
                                                            fontSize: 30,
                                                            fontFeatures: [
                                                              const FontFeature
                                                                      .enable(
                                                                  'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mukta(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        "°",
                                                        style: GoogleFonts.mukta(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium,
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/' +
                                                        getForecastWeather(
                                                            0)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        1)["weatherName"],
                                                    style: GoogleFonts.mukta(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    getForecastWeather(1)[
                                                                "chanceOfRain"]
                                                            .toString() +
                                                        "%",
                                                    style: GoogleFonts.mukta(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                      color:
                                                          _constants.greyColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: _constants.primaryColor,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    2)["forecastDate"],
                                                style: GoogleFonts.mukta(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mukta(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        "°",
                                                        style: GoogleFonts.mukta(
                                                            textStyle: Theme
                                                                    .of(context)
                                                                .textTheme
                                                                .displayMedium,
                                                            color: _constants
                                                                .greyColor,
                                                            fontSize: 30,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.mukta(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        "°",
                                                        style: GoogleFonts.mukta(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium,
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/' +
                                                        getForecastWeather(
                                                            2)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        0)["weatherName"],
                                                    style: GoogleFonts.mukta(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    getForecastWeather(2)[
                                                                "chanceOfRain"]
                                                            .toString() +
                                                        "%",
                                                    style: GoogleFonts.mukta(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                      color:
                                                          _constants.greyColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
