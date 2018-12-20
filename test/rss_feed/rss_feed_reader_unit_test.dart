import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:webfeed/webfeed.dart';
import 'package:influx/utility/rss_feed/rss_feed_reader.dart';

void main() {
  test('RSS feed reader test', () async {
    // mock objects:
    final mockHttpClient = MockClient((request) async => Response('', 200));
    final mockRssFeed = MockRssFeed();
    when(mockRssFeed.items).thenReturn(<RssItem>[
      RssItem(title: 'Title 1', link: 'www.in.flux/1', pubDate: 'Wed, 28 Nov 2018 18:48:01 +0100'),
      RssItem(title: 'Title 2', link: 'www.in.flux/2', pubDate: 'Wed, 28 Nov 2018 18:48:02 +0100'),
      RssItem(title: 'Title 2', link: 'www.in.flux/2', pubDate: 'Wed, 28 Nov 2018 18:48:03 +0100'),
    ]);

    // create the RssFeedReader:
    final rssFeedReader = RssFeedReader(
        url: 'http://www.awesometestfeed.org/feed',
        rssFeedParser: (s) => mockRssFeed,
        httpClient: mockHttpClient);

    // call the fetch() method:
    final postCount = 3;
    final result = await rssFeedReader.fetchRssPosts(postCount);
    expect(result.length, postCount);
  });

  test('RSS feed reader bad items test', () async {
    // mock objects:
    final mockHttpClient = MockClient((request) async => Response('', 200));
    final mockRssFeed = MockRssFeed();
    when(mockRssFeed.items).thenReturn(<RssItem>[
      RssItem(title: 'Title 1', link: 'www.in.flux/1', pubDate: 'Wed, 28 Nov 2018 18:48:01 +0100'),
      RssItem(title: 'Title 2'),
      RssItem(link: 'www.in.flux/2',),
    ]);

    // create the RssFeedReader:
    final rssFeedReader = RssFeedReader(
        url: 'http://www.awesometestfeed.org/feed',
        rssFeedParser: (s) => mockRssFeed,
        httpClient: mockHttpClient);

    // call the fetch() method:
    final postCount = 3;
    final result = await rssFeedReader.fetchRssPosts(postCount);
    expect(result.length, 1);
  });

  test('RSS feed reader: DateTime formatting test', () async {
    final rssFeedReader = RssFeedReader(
        url: null, rssFeedParser: (s) => MockRssFeed(), httpClient: null);

    final String dateString1 = 'Fri, 07 Dec 2018 15:49:56 GMT';
    final date1 = rssFeedReader.parseRssDate(dateString1);
    expect(date1.year, 2018);
    expect(date1.month, DateTime.december);
    expect(date1.day, 7);

    final String dateString2 = 'Sat, 17 Nov 2017 05:50:14 GMT';
    final date2 = rssFeedReader.parseRssDate(dateString2);
    expect(date2.year, 2017);
    expect(date2.month, DateTime.november);
    expect(date2.day, 17);
  });
}

class MockRssFeed extends Mock implements RssFeed {}
