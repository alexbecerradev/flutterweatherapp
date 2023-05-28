import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weatherapp/models/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/ui/home_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStarted();
}

class _GetStarted extends State<GetStarted> {
  static String apiKey = 'a7bf836d509549e696c171848232005';
  // ignore: prefer_interpolation_to_compose_strings
  String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=" +
      apiKey +
      "&days=7&q=";

  String location = 'London';
  String weatherIcon = 'heavyrain.png';
  int temperature = 5;
  int windSpeed = 10;
  int humidity = 20;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  String currentWeatherStatus = '';

  get http => null;

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

      var locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        location = getShortLocationName(locationData["name"]);

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        currentWeatherStatus = currentWeather['condition']['text'];
        weatherIcon =
            '${currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png';
        temperature = currentWeather['temp_c'].toInt();
        windSpeed = currentWeather['wind_kph'].toInt();
        humidity = currentWeather['humidity'].toInt();
        cloud = currentWeather['cloud'].toInt();

        // forecast data
        dailyWeatherForecast = weatherData['forecast']['forecastday'];
        hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordlist = s.split(" ");

    if (wordlist.isNotEmpty) {
      if (wordlist.length > 1) {
        return "${wordlist[0]} ${wordlist[1]}";
      } else {
        return wordlist[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    final Constants constants = Constants();

    return Scaffold(
      backgroundColor: constants.backgroundColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 200,
                width: 400,
                child: Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_yu0tsC9558.json',
                ),
              ),
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Check the real-time weather in your city.',
                  style: GoogleFonts.mukta(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () {
                  cityController.clear();
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      controller: ModalScrollController.of(context),
                      child: Container(
                        height: size.height * .6,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                              child: Divider(
                                thickness: 3.5,
                                color: constants.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              selectLocation:
                                                  cityController.text,
                                            )));
                              },
                              onChanged: (searchText) {
                                fetchWeatherData(searchText);
                              },
                              controller: cityController,
                              autofocus: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: constants.primaryColor,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () => {
                                    cityController.clear(),
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: constants.primaryColor,
                                  ),
                                ),
                                hintText: 'Search city',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: constants.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: constants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.mukta(
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
