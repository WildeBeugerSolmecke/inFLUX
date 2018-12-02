import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:influx/widgets/RssFeedPage.dart';
import 'package:influx/utility/RssFeedReader.dart';
import 'package:influx/config.dart';

void main() {
  testWidgets('RssFeedReader widget test', (WidgetTester tester) async {
    // a mock HTTP client:
    var mockHttpClient = MockClient((request) async {
      String body = mockRssResponse;
      return Response(body, 200);
    });

    // wrap the RssFeedReader widget with a MaterialApp in order to have a MediaQuery object:
    var testWidget = MaterialApp(
        home: RssFeedPage(
            title: 'Test Widget',
            rssFeedReader: RssFeedReader(
                url: InFluxConfig.rssFeedUrl, httpClient: mockHttpClient
            )
        )
    );

    // pump the widget:
    await tester.runAsync(() async {
      await tester.pumpWidget(testWidget);
    });

    // verify that the RSS feed items are rendered:
    // TODO: expect(find.text('RSS feed item one'), findsOneWidget);
  });
}

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
