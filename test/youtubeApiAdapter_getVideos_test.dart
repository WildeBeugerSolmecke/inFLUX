import 'package:influx/utility/Youtube/ThumbnailSize.dart';
import 'package:influx/utility/Youtube/YoutubeApiAdapter.dart';
import 'package:influx/utility/Youtube/YoutubeVideoInfo.dart';
import 'package:test_api/test_api.dart';

void main() {
  test('fetching the last 20 video from "kanzleiwbs" youtube channel', () async {
    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter();
    List<YoutubeVideoInfo> videos = await youtubeApiAdapter.getVideos("UCb5TfGtSgvNPVPQawfCFuAw", "AIzaSyBoht9JEZzn_-E6p3tHVsErOyL77yXko_M", 20);
    assert(videos.length==20);
    assert(videos[0].id!=null);
    assert(videos[0].thumbnailUrls.containsKey(ThumbnailSize.SMALL));
    assert(videos[0].publishedAt != null);
  });
}