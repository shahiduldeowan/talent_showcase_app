import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String get appBaseUrl {
    return dotenv.get('BASE_URL', fallback: 'BASE_URL not found');
  }
}
