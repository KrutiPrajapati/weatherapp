import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/utils/colors.dart';
import 'package:weatherapp/resources/weatherModel.dart';
import 'package:weatherapp/resources/weatherServices.dart';
import 'package:weatherapp/utils/utils.dart';
import 'package:weatherapp/weatherDetailScreen.dart';
import 'package:weatherapp/widgets/myTextFormField.dart';
import 'package:weatherapp/widgets/searchHistoryContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String searchValue = '';
  final _weatherServices = WeatherServices();
  WeatherResponse? _weatherResponse;

  @override
  void initState() {
    super.initState();
    _loadLastSearch();
  }

  _loadLastSearch() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSearch = prefs.getString('last_search');

    if (lastSearch != null) {
      searchController.text = lastSearch;
      search();
    }
  }

  _saveLastSearch(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_search', cityName);
  }

  search() async {
    showLoadingIndicator(context);

    final response = await _weatherServices.getWeather(searchController.text);
    setState(() {
      _weatherResponse = response;
    });

    cancelLoadingCircle(context);

    if (_weatherResponse != null) {
      _saveLastSearch(_weatherResponse!.cityName);
      searchController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailScreen(
            weatherResponse: _weatherResponse!,
          ),
        ),
      );
    } else {
      showSnackBar(context, "Please enter city name properly!");
    }
  }

  //
  onFieldSubmitted() {
    setState(() {
      searchValue = searchController.text;
    });
    search();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "W E A T H E R",
          style: TextStyle(
            fontSize: 20,
            color: whiteColor,
          ),
        ),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // textfield for search input
                      Expanded(
                        child: MyTextFormField(
                          onFieldSubmitted: () {
                            onFieldSubmitted();
                          },
                          searchController: searchController,
                          hintText: 'Search',
                          icon: const Icon(
                            Icons.search_rounded,
                            color: whiteColor,
                          ),
                        ),
                      ),

                      const SizedBox(width: 7),

                      // text button : search
                      Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: TextButton(
                          onPressed: () {
                            if (searchController.text.isNotEmpty) {
                              onFieldSubmitted();
                            }
                          },
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  Flexible(child: Container()),

                  // last search history
                  if (_weatherResponse != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your last search",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 14,
                            color: whiteColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SearchHistoryContainer(
                          cityName: _weatherResponse!.cityName,
                          description:
                              _weatherResponse!.weatherInfo.description,
                          imageUrl: _weatherResponse!.iconUrl,
                          temperature:
                              _weatherResponse!.tempInfo.temp.toString(),
                        ),
                      ],
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
