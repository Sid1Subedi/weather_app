class GeoEncodingModelResponse {
  final String? name;
  final Map<String, String>? localNames;
  final double? lat;
  final double? lon;
  final String? country;
  final String? state;

  GeoEncodingModelResponse({
    this.name,
    this.localNames,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  factory GeoEncodingModelResponse.fromJson(Map<String, dynamic> json) {
    return GeoEncodingModelResponse(
      name: json['name'] ?? '',
      localNames:
          (json['local_names'] as Map<String, dynamic>).cast<String, String>(),
      lat: double.tryParse(json['lat']?.toString() ?? ''),
      lon: double.tryParse(json['lon']?.toString() ?? ''),
      country: json['country'] ?? '',
      state: json['state'] ?? '',
    );
  }
}
