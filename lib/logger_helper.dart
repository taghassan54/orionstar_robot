import 'package:logger/logger.dart';

class LoggerHelper {
  static var logger = Logger();

  static verbose(String message) => logger.v(message);

  static debug(String message) => logger.d(message);

  static warning(String message) => logger.w(message);

  static info(String message) => logger.i(message);

  static error(String message) => logger.e(message);

  static wtf(String message) => logger.wtf(message);

  static infoStars(String message) => logger.i("******************************** $message********************************");
}
