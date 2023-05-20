import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static String url = dotenv.get('url');
  static String dbLink = dotenv.get('Link');
}
