class Configuration {
  static const host = 'https://identitytoolkit.googleapis.com/v1';
  static const signInUrl = '/accounts:signInWithPassword';
  static const apiKey = String.fromEnvironment('API_KEY');
}
