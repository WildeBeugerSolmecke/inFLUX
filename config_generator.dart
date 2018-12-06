import 'dart:io';
import 'dart:convert';

void main() {
  final cg = ConfigGenerator();
  final props = cg.readUserConfigValues();
  // TODO: generate navigation bars and routes
  cg.writeUserConfigValues(props);
}

/// Reads configuration values from users and generates a Dart config class.
/// See: ./lib/config.dart
class ConfigGenerator {
  static const String doYouWantToUseX = 'Do you want to use';
  static const String YES = 'yes';
  static const String NO = 'no';

  /// Prompts the user for all necessary properties and read them
  /// from command line.
  InfluxConfigProperties readUserConfigValues() {
    final props = InfluxConfigProperties();

    try {
      var q = '$doYouWantToUseX an \'RSS Feed Widget\'?';
      props.useRssFeedWidget = _readBoolValue(q, true, YES);
      if (props.useRssFeedWidget) {
        q = 'Enter the RSS feed\'s URL (e.g. \'http://rss.cnn.com/rss/edition.rss\'):';
        props.rssFeedUrl = _readStringValue(q, null);
      }
      stdout.write('\n');

      q = '$doYouWantToUseX a \'Youtube Channel Widget\'?';
      props.useYoutubeChannelWidget = _readBoolValue(q, true, YES);
      if (props.useRssFeedWidget) {
        // TODO: read all Youtube Channel props
      }
      stdout.write('\n');

      // TODO: read all other props...

    } catch (e) {
      stderr.writeln('Malformed input! Could not setup your App.');
    }

    return props;
  }

  /// Writes the properties object into the config.dart file.
  void writeUserConfigValues(InfluxConfigProperties props) async {
    final dartConfigFile = File('./lib/config.dart');

    final Stream<String> dartConfigFileStream = dartConfigFile
        .openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());

    // match type/name tuples in the existing config class and replace their
    // assigned values with the ones provided by the user:
    final List<String> customizedLines = await dartConfigFileStream
        .map((l) => _replaceIfContains(l, RegExp(r'MaterialColor primaryColor'), RegExp(r'Colors.blue'), props.primaryColor))
        // TODO: also replace the other values...
        .map((l) => _replaceIfContains(l, RegExp(r'String rssFeedUrl'), RegExp(r"'http://rss.cnn.com/rss/edition.rss'"), "'${props.rssFeedUrl}'"))
        .toList();

    final IOSink sink = dartConfigFile.openWrite();
    customizedLines.forEach((line) {
      sink.writeln(line);
    });

    await sink.flush();
    await sink.close();
  }

  bool _readBoolValue(
      String question, bool defaultValue, String defaultValueToDisplay) {
    stdout.write(question + ' [$defaultValueToDisplay] ');
    String input = stdin.readLineSync();

    if (input.isEmpty) {
      return defaultValue;
    } else if (input.trim().toLowerCase() == YES) {
      return true;
    } else if (input.trim().toLowerCase() == NO) {
      return false;
    } else {
      throw TypeError();
    }
  }

  String _readStringValue(String question, String defaultValue) {
    if (defaultValue != null) {
      stdout.write(question + ' [$defaultValue] ');
    } else {
      stdout.write(question + ' ');
    }

    String input = stdin.readLineSync();
    if (input.isEmpty) {
      if (defaultValue != null) {
        return defaultValue;
      } else {
        throw ArgumentError();
      }
    } else {
      return input;
    }
  }

  String _replaceIfContains(
      String l, RegExp typeNameTuple, RegExp oldValue, String newValue) {
    if (l.contains(typeNameTuple)) {
      return l.replaceAll(oldValue, newValue);
    }
    return l;
  }
}

class InfluxConfigProperties {
  // RSS feed props:
  bool useRssFeedWidget;
  String rssFeedUrl = '\'\'';

  // Youtube channel props:
  bool useYoutubeChannelWidget;

  // styling:
  String primaryColor = 'Colors.red';

  InfluxConfigProperties({this.useRssFeedWidget, this.useYoutubeChannelWidget});
}
