class Configuration {
  /// Firebase
  static const authHost = 'https://identitytoolkit.googleapis.com/v1';
  static const authSignInUrl = '/accounts:signInWithPassword';
  static const authApiKey = String.fromEnvironment('AUTH_API_KEY');

  /// OpenWeather
  static const weatherHost = 'https://api.openweathermap.org';
  static const weatherForecastUrl = '/data/2.5/forecast';
  static const weatherAppId = '72733294fe848ca35c7c26ef08550576';
}
