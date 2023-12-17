import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CityData {
  static List<City> _cities = [];

  static Future<void> loadCityData() async {
    try {
      final String jsonString = await rootBundle
          .loadString('assets/city_list_json/city.list.min.json');

      final List<dynamic> citiesData = jsonDecode(jsonString);

      _cities = citiesData.map((data) => City.fromJson(data)).toList();
    } catch (e) {
      debugPrint('Error loading city data: $e');
    }
  }

  static List<City> getAllCities() {
    return _cities;
  }

  static List<String> getAllCityNames() {
    return _cities.map((city) => city.name).toList();
  }
}

class City {
  final int id;
  final String name;
  final String state;
  final String country;
  final Coord coord;

  City({
    this.id = 0,
    this.name = '',
    this.state = '',
    this.country = '',
    this.coord = const Coord(),
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      coord: Coord.fromJson(json['coord'] ?? const {}),
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  const Coord({
    this.lon = 0.0,
    this.lat = 0.0,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
    );
  }
}