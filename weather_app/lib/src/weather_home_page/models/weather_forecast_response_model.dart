class WeatherForecastResponseModel {
  String? cod;
  String? message;
  int? cnt;
  List<WeatherForecastData>? list;
  City? city;

  WeatherForecastResponseModel.fromJson(Map<String, dynamic>? json) {
    cod = json?['cod']?.toString();
    message = json?['message']?.toString();
    cnt = int.tryParse(json?['cnt']?.toString() ?? '');
    list = (json?['list'] as List<dynamic>?)
        ?.map((data) => WeatherForecastData.fromJson(data as Map<String, dynamic>))
        .toList();
    city = json?['city'] != null ? City.fromJson(json?['city'] as Map<String, dynamic>) : null;
  }
}

class WeatherForecastData {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Sys? sys;
  String? dtTxt;

  WeatherForecastData.fromJson(Map<String, dynamic>? json) {
    dt = int.tryParse(json?['dt']?.toString() ?? '');
    main = json?['main'] != null ? Main.fromJson(json?['main'] as Map<String, dynamic>) : null;
    weather = (json?['weather'] as List<dynamic>?)
        ?.map((data) => Weather.fromJson(data as Map<String, dynamic>))
        .toList();
    clouds = json?['clouds'] != null ? Clouds.fromJson(json?['clouds'] as Map<String, dynamic>) : null;
    wind = json?['wind'] != null ? Wind.fromJson(json?['wind'] as Map<String, dynamic>) : null;
    visibility = int.tryParse(json?['visibility']?.toString() ?? '');
    pop = double.tryParse(json?['pop']?.toString() ?? '');
    sys = json?['sys'] != null ? Sys.fromJson(json?['sys'] as Map<String, dynamic>) : null;
    dtTxt = json?['dt_txt'] as String?;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  Main.fromJson(Map<String, dynamic>? json) {
    temp = double.tryParse(json?['temp']?.toString() ?? '');
    feelsLike = double.tryParse(json?['feels_like']?.toString() ?? '');
    tempMin = double.tryParse(json?['temp_min']?.toString() ?? '');
    tempMax = double.tryParse(json?['temp_max']?.toString() ?? '');
    pressure = int.tryParse(json?['pressure']?.toString() ?? '');
    seaLevel = int.tryParse(json?['sea_level']?.toString() ?? '');
    grndLevel = int.tryParse(json?['grnd_level']?.toString() ?? '');
    humidity = int.tryParse(json?['humidity']?.toString() ?? '');
    tempKf = double.tryParse(json?['temp_kf']?.toString() ?? '');
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather.fromJson(Map<String, dynamic>? json) {
    id = int.tryParse(json?['id']?.toString() ?? '');
    main = json?['main']?.toString();
    description = json?['description']?.toString();
    icon = json?['icon']?.toString();
  }
}

class Clouds {
  int? all;

  Clouds.fromJson(Map<String, dynamic>? json) {
    all = int.tryParse(json?['all']?.toString() ?? '');
  }
}

class Wind {
  double? speed;
  double? deg;
  double? gust;

  Wind.fromJson(Map<String, dynamic>? json) {
    speed = double.tryParse(json?['speed']?.toString() ?? '');
    deg = double.tryParse(json?['deg']?.toString() ?? '');
    gust = double.tryParse(json?['gust']?.toString() ?? '');
  }
}

class Sys {
  String? pod;

  Sys.fromJson(Map<String, dynamic>? json) {
    pod = json?['pod']?.toString();
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City.fromJson(Map<String, dynamic>? json) {
    id = int.tryParse(json?['id']?.toString() ?? '');
    name = json?['name']?.toString();
    coord = json?['coord'] != null ? Coord.fromJson(json?['coord'] as Map<String, dynamic>) : null;
    country = json?['country']?.toString();
    population = int.tryParse(json?['population']?.toString() ?? '');
    timezone = int.tryParse(json?['timezone']?.toString() ?? '');
    sunrise = int.tryParse(json?['sunrise']?.toString() ?? '');
    sunset = int.tryParse(json?['sunset']?.toString() ?? '');
  }
}

class Coord {
  double? lat;
  double? lon;

  Coord.fromJson(Map<String, dynamic>? json) {
    lat = double.tryParse(json?['lat']?.toString() ?? '');
    lon = double.tryParse(json?['lon']?.toString() ?? '');
  }
}
