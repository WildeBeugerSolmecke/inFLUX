import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:webfeed/webfeed.dart';
import 'package:influx/utility/RssFeedReader.dart';

void main() {
  test('RSS feed reader test', () {
    // mock objects:
    var mockRssFeed = MockRssFeed();
    var mockHttpClient = MockClient((request) async {
      String body = mockRssResponse;
      return Response(body, 200);
    });

    var rssFeedReader = RssFeedReader.build(
        url: 'http://www.awesometestfeed.org/feed',
        rssFeedParser: (s) => RssFeed.parse(s),
        httpClient: mockHttpClient
    );

    rssFeedReader.fetchRssPosts(2).then((posts) => expect(posts.length, 2));
  });
}

class MockRssFeed extends Mock implements RssFeed {}

const mockRssResponse = '<?xml version="1.0" encoding="UTF-8" ?>' +
    '<?xml-stylesheet href="/resources/xsl/rss2.jsp" type="text/xsl"?>' +
    '<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/">' +
    '<channel>' +
    '<title>Test RSS Feed</title>' +
    '<link>http://www.awesometestfeed.org</link>' +
    '<description>awesometestfeed.org</description>' +
    '<language>en</language>' +
    '<lastBuildDate>Wed, 28 Nov 2018 19:28:29 +0100</lastBuildDate>' +
    '<docs>http://blogs.law.harvard.edu/tech/rss</docs>' +
    '<ttl>10</ttl>' +
    '<item>' +
    '<title>RSS feed item one</title>' +
    '<link>http://www.awesometestfeed.org/one.html</link>' +
    '<pubDate>Wed, 28 Nov 2018 18:48:01 +0100</pubDate>' +
    '<content:encoded>' +
    '<![CDATA[' +
    '<p>one one one</p>' +
    ']]>' +
    '</content:encoded>' +
    '<description>feed item number one</description>' +
    '<guid>101</guid>' +
    '</item>' +
    '<item>' +
    '<title>RSS feed item two</title>' +
    '<link>http://www.awesometestfeed.org/two.html</link>' +
    '<pubDate>Wed, 28 Nov 2018 18:48:01 +0100</pubDate>' +
    '<content:encoded>' +
    '<![CDATA[' +
    '<p>two two two</p>' +
    ']]>' +
    '</content:encoded>' +
    '<description>feed item number two</description>' +
    '<guid>101</guid>' +
    '</item>' +
    '<item>' +
    '<title>RSS feed item three</title>' +
    '<link>http://www.awesometestfeed.org/three.html</link>' +
    '<pubDate>Wed, 28 Nov 2018 18:48:01 +0100</pubDate>' +
    '<content:encoded>' +
    '<![CDATA[' +
    '<p>three three three</p>' +
    ']]>' +
    '</content:encoded>' +
    '<description>feed item number three</description>' +
    '<guid>101</guid>' +
    '</item>' +
    '</channel>' +
    '</rss>';
