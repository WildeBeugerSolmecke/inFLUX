import 'package:influx/config.dart';
import 'package:influx/utility/Youtube/model/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_api_adapter.dart';
import 'package:influx/utility/Youtube/model/youtube_channel_with_videos.dart';
import 'package:test_api/test_api.dart';

import 'http_client_youtube_wbs_mock.dart';

void main() {
  test('fetching wbs channel data and the last 20 videos', () async {
    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter();
    YoutubeChannelWithVideos youtubeData =
        await youtubeApiAdapter.getYoutubeChannelAndVideos(
            httpClient: HttpClientYoutubeWbsMock(),
            apiKey: InFluxConfig.youtubeApiKey,
            channelId: "UCb5TfGtSgvNPVPQawfCFuAw",
            maxResults: 20
        );

    assert(youtubeData.channel.id == "UCb5TfGtSgvNPVPQawfCFuAw");
    assert(youtubeData.channel.title == "Kanzlei WBS");
    assert(youtubeData.videos[0].description != null);
    assert(youtubeData.videos[0].thumbnailUrls.containsKey(ThumbnailSize.LARGE));
    assert(youtubeData.videos.length == 20);
  });
}
