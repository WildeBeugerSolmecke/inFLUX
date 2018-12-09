import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'youtube_responses.dart';
import 'dart:convert';

class HttpClientYoutubeWbsMock extends Mock implements Client {
  HttpClientYoutubeWbsMock() {

    String jsonAsString = YoutubeResponses.wbsVideoInfos;
    final data = json.encode(jsonAsString);
    jsonAsString = json.decode(data);

    when(this.get(contains("https://www.googleapis.com/youtube/v3/channels")))
        .thenAnswer((_) async => Response(YoutubeResponses.wbsChannelInfo, 200, headers: {'content-type': 'application/json; charset=utf-8'}));
    when(this.get(contains("https://www.googleapis.com/youtube/v3/search")))
        .thenAnswer((_) async => Response(YoutubeResponses.wbsVideoInfos, 200, headers: {'content-type': 'application/json; charset=utf-8'}));
  }
}
