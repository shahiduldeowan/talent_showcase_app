import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart' as logger_package;
import 'package:talent_showcase_app/core/di/di.dart' show getIt;

final LoggerService logger = getIt<LoggerService>();

enum LogLevel {
  debug(0),
  info(1),
  warning(2),
  error(3);

  final int value;
  const LogLevel(this.value);

  bool operator <=(LogLevel level) => value <= level.value;
}

abstract class LoggerService {
  void d(dynamic message, {dynamic error, StackTrace? stackTrace});
  void i(dynamic message, {dynamic error, StackTrace? stackTrace});
  void w(dynamic message, {dynamic error, StackTrace? stackTrace});
  void e(dynamic message, {dynamic error, StackTrace? stackTrace});
}

@Singleton(as: LoggerService)
class AppLogger implements LoggerService {
  final logger_package.Logger _logger;
  LogLevel _logLevel;

  /// Manually toggle debug mode for environments like staging
  static bool debugEnabled = kDebugMode;

  AppLogger()
    : _logLevel = LogLevel.debug,
      _logger = logger_package.Logger(
        printer: _CustomLogPrinter(),
        output: _CustomLogOutput(),
        filter: _CustomLogFilter(),
      );

  set logLevel(LogLevel level) => _logLevel = level;

  @override
  void d(dynamic message, {dynamic error, StackTrace? stackTrace}) =>
      _log(LogLevel.debug, message, error, stackTrace);

  @override
  void i(dynamic message, {dynamic error, StackTrace? stackTrace}) =>
      _log(LogLevel.info, message, error, stackTrace);

  @override
  void w(dynamic message, {dynamic error, StackTrace? stackTrace}) =>
      _log(LogLevel.warning, message, error, stackTrace);

  @override
  void e(dynamic message, {dynamic error, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, error, stackTrace);

  void _log(
    LogLevel level,
    dynamic message,
    dynamic error,
    StackTrace? stackTrace,
  ) {
    if (_logLevel <= level) {
      _logger.log(
        _toLoggerLevel(level),
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  logger_package.Level _toLoggerLevel(LogLevel level) {
    return switch (level) {
      LogLevel.debug => logger_package.Level.debug,
      LogLevel.info => logger_package.Level.info,
      LogLevel.warning => logger_package.Level.warning,
      LogLevel.error => logger_package.Level.error,
    };
  }
}

class _CustomLogPrinter extends logger_package.LogPrinter {
  final bool _enableColors = AppLogger.debugEnabled;

  static const Map<logger_package.Level, String> _prefixMap =
      <logger_package.Level, String>{
        logger_package.Level.debug: '🐛 DEBUG',
        logger_package.Level.info: '💡 INFO ',
        logger_package.Level.warning: '⚠️ WARN',
        logger_package.Level.error: '⛔ ERROR',
      };

  static const Map<logger_package.Level, String> _colorMap =
      <logger_package.Level, String>{
        logger_package.Level.debug: '\x1B[34m',
        logger_package.Level.info: '\x1B[32m',
        logger_package.Level.warning: '\x1B[33m',
        logger_package.Level.error: '\x1B[31m',
      };

  @override
  List<String> log(logger_package.LogEvent event) {
    final String timestamp = DateTime.now().toString().substring(11, 23);
    final String prefix = _prefixMap[event.level] ?? 'LOG  ';
    final String color = _colorMap[event.level] ?? '';

    return <String>[
      '${_enableColors ? color : ''}$timestamp $prefix ${event.message}'
          '${errorStr(event.error)}${stackTraceStr(event.stackTrace)}'
          '${_enableColors ? '\x1B[0m' : ''}',
    ];
  }

  String errorStr(dynamic error) => error != null ? '\nError: $error' : '';
  String stackTraceStr(StackTrace? stack) => stack != null ? '\n$stack' : '';
}

class _CustomLogFilter extends logger_package.LogFilter {
  @override
  bool shouldLog(logger_package.LogEvent event) {
    return AppLogger.debugEnabled ||
        event.level.index >= logger_package.Level.info.index;
  }
}

class _CustomLogOutput extends logger_package.LogOutput {
  @override
  void output(logger_package.OutputEvent event) {
    for (final String line in event.lines) {
      debugPrint(line);
    }
  }
}
