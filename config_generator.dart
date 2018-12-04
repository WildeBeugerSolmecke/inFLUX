import 'dart:io';

void main() {
  final cg = ConfigGenerator();
  cg.readUserConfigValues();
  cg.writeUserConfigValues();
}

class ConfigGenerator {
  static const String doYouWantToUseX = 'Do you want to use';
  static const String YES = 'yes';
  static const String NO = 'no';

  void readUserConfigValues() {
    try {
      var q = '$doYouWantToUseX an \'RSS Feed Widget\'?';
      final bool useRssFeedWidget = readBoolValue(q, true, YES);

      q = '$doYouWantToUseX a \'Youtube Channel Widget\'?';
      final bool useYoutubeChannelWidget = readBoolValue(q, true, YES);

    } catch (e) {
      stderr.writeln('Malformed input! Could not setup your App.');
    }
  }

  bool readBoolValue(String question, bool defaultValue, String defaultValueToDisplay) {
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

  String readStringValue(String question, String defaultValue) {
    stdout.write(question);
    String input = stdin.readLineSync();
    print('Input was: $input');
    return input;
  }

  void writeUserConfigValues() {
    // TODO!
  }
}
