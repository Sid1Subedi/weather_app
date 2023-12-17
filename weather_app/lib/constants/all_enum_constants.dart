//region Temperature Unit Enum

enum TemperatureUnitEnum {
  imperial,
  metric,
}

extension TemperatureUnitEnumString on TemperatureUnitEnum {
  String toTemperatureUnitString() {
    switch (this) {
      case TemperatureUnitEnum.imperial:
        return 'Imperial';
      case TemperatureUnitEnum.metric:
        return 'Metric';
      default:
        return ''; // Handle any additional cases if necessary
    }
  }
}

//endregion

//region Languages Enum

enum LanguageEnum {
  english,
  arabic,
}

extension LanguageEnumString on LanguageEnum {
  String toLanguageString() {
    switch (this) {
      case LanguageEnum.english:
        return 'en';
      case LanguageEnum.arabic:
        return 'ar';
      default:
        return ''; // Handle any additional cases if necessary
    }
  }
}

//endregion