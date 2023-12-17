class CurrentWeatherResponseModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  String? cod;
  String? message;

  CurrentWeatherResponseModel.fromJson(Map<String, dynamic>? json) {
    coord = json?['coord'] != null ? Coord.fromJson(json!['coord']!) : null;

    if (json?['weather'] != null) {
      weather = [];
      (json?['weather'] as List<dynamic>?)?.forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }

    base = json?['base']?.toString();
    main = json?['main'] != null ? Main.fromJson(json?['main']) : null;
    visibility = json?['visibility']?.toInt();
    wind = json?['wind'] != null ? Wind.fromJson(json?['wind']) : null;
    clouds = json?['clouds'] != null ? Clouds.fromJson(json?['clouds']) : null;
    dt = json?['dt']?.toInt();
    sys = json?['sys'] != null ? Sys.fromJson(json?['sys']) : null;
    timezone = json?['timezone']?.toInt();
    id = json?['id']?.toInt();
    name = json?['name']?.toString();
    cod = json?['cod']?.toString();
    message = json?['message']?.toString();
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord.fromJson(Map<String, dynamic>? json) {
    lon = json?['lon']?.toDouble();
    lat = json?['lat']?.toDouble();
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather.fromJson(Map<String, dynamic>? json) {
    id = json?['id']?.toInt();
    main = json?['main']?.toString();
    description = json?['description']?.toString();
    icon = json?['icon']?.toString();
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  Main.fromJson(Map<String, dynamic>? json) {
    temp = json?['temp']?.toDouble();
    feelsLike = json?['feels_like']?.toDouble();
    tempMin = json?['temp_min']?.toDouble();
    tempMax = json?['temp_max']?.toDouble();
    pressure = json?['pressure']?.toInt();
    humidity = json?['humidity']?.toInt();
  }
}

class Wind {
  double? speed;
  int? deg;

  Wind.fromJson(Map<String, dynamic>? json) {
    speed = json?['speed']?.toDouble();
    deg = json?['deg']?.toInt();
  }
}

class Clouds {
  int? all;

  Clouds.fromJson(Map<String, dynamic>? json) {
    all = json?['all']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys.fromJson(Map<String, dynamic>? json) {
    type = json?['type']?.toInt();
    id = json?['id']?.toInt();
    country = json?['country']?.toString();
    sunrise = json?['sunrise']?.toInt();
    sunset = json?['sunset']?.toInt();
  }
}
