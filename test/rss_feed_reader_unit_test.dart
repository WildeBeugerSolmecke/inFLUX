import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:webfeed/webfeed.dart';
import 'package:influx/utility/RssFeedReader.dart';

void main() {
  test('RSS feed reader test', () async {
    // mock objects:
    var mockHttpClient = MockClient((request) async => Response('', 200));
    var mockRssFeed = MockRssFeed();
    when(mockRssFeed.items).thenReturn(<MockRssItem>[
      MockRssItem(),
      MockRssItem(),
      MockRssItem(),
    ]);

    // create the RssFeedReader:
    var rssFeedReader = RssFeedReader.build(
        url: 'http://www.awesometestfeed.org/feed',
        rssFeedParser: (s) => mockRssFeed,
        httpClient: mockHttpClient);

    // call the fetch() method:
    final postCount = 3;
    var result = await rssFeedReader.fetchRssPosts(postCount);
    expect(result.length, postCount);
  });
}

class MockRssFeed extends Mock implements RssFeed {}

class MockRssItem extends Mock implements RssItem {}
