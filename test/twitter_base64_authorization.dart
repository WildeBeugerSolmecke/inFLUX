import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

const UTF8 = Utf8Codec();
const BASE64 = Base64Codec();

void main() {
  test('building base64 twitter basic auth', () {
    String encodedApiKey = Uri.encodeQueryComponent("API-KEY");
    String encodedApiSecret = Uri.encodeQueryComponent("API-SECRET");

    String tokenCredentials = encodedApiKey + ":" + encodedApiSecret;
    var bytes = UTF8.encode(tokenCredentials);
    var base64encodedTokenCredentials = BASE64.encode(bytes);
    print(base64encodedTokenCredentials);
});
}