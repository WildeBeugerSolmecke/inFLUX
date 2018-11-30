import 'package:http/http.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_api_adapter.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';
import 'package:test_api/test_api.dart';

import 'http_client_youtube_wbs_mock.dart';


void main() {
  test('fetching the last 20 video from wbs youtube channel', () async {

    YoutubeApiAdapter youtubeApiAdapter = YoutubeApiAdapter();
    List<YoutubeVideoInfo> videos = await youtubeApiAdapter.getVideos(httpClient: HttpClientYoutubeWbsMock(),apiKey: InFluxConfig.youtubeApiKey, channelId: InFluxConfig.youtubeChannelId, maxResults: 20);

    assert(videos.length==20);
    assert(videos[0].id!=null);
    assert(videos[0].thumbnailUrls.containsKey(ThumbnailSize.SMALL));
    assert(videos[0].publishedAt != null);
    assert(videos[0].description != null);
  });
}
