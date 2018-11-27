import 'package:flutter_test/flutter_test.dart';
import 'package:influx/utility/Youtube/YoutubeChannelInfo.dart';
import '../lib/utility/Youtube/YoutubeApiAdapter.dart';

void main() {
  test('my first unit test', () async {
    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter();
    YoutubeChannelInfo youtubeChannelInfo = await youtubeApiAdapter.getChannelInfo("kanzleiwbs", "AIzaSyBoht9JEZzn_-E6p3tHVsErOyL77yXko_M");
    assert(youtubeChannelInfo.title == "Kanzlei WBS");
    assert(youtubeChannelInfo.description.contains("Rechtsprechung "));
    assert(youtubeChannelInfo.thumbnails.containsKey(Size.SMALL));
    assert(youtubeChannelInfo.id == "UCb5TfGtSgvNPVPQawfCFuAw");
  });
}