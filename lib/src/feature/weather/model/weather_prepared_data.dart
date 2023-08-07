class WeatherPreparedData {
  final String temperature;
  final String description;
  final String icon;
  final String tempMin;
  final String tempMax;
  final String date;
  final String time;
  final String windSpeed;
  final String windDirection;
  final String humidity;
  final String humidityDescription;

  WeatherPreparedData({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.tempMin,
    required this.tempMax,
    required this.date,
    required this.time,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.humidityDescription,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherPreparedData &&
        other.temperature == temperature &&
        other.description == description &&
        other.icon == icon &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.date == date &&
        other.time == time &&
        other.windSpeed == windSpeed &&
        other.windDirection == windDirection &&
        other.humidity == humidity &&
        other.humidityDescription == humidityDescription;
  }

  @override
  int get hashCode {
    return temperature.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        date.hashCode ^
        time.hashCode ^
        windSpeed.hashCode ^
        windDirection.hashCode ^
        humidity.hashCode ^
        humidityDescription.hashCode;
  }
}
