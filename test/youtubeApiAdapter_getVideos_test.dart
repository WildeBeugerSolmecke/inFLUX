import 'package:influx/config.dart';
import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_api_adapter.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';
import 'package:test_api/test_api.dart';

void main() {
  test('fetching the last 20 video from youtube channel', () async {
    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter();
    List<YoutubeVideoInfo> videos = await youtubeApiAdapter.getVideos(apiKey: InFluxConfig.youtubeApiKey, channelId: InFluxConfig.youtubeChannelId, results: 20);
    assert(videos.length==20);
    assert(videos[0].id!=null);
    assert(videos[0].thumbnailUrls.containsKey(ThumbnailSize.SMALL));
    assert(videos[0].publishedAt != null);
  });
}
