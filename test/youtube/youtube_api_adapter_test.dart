import 'package:flutter_test/flutter_test.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:influx/utility/youtube/youtube_api_adapter.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_channel_with_videos.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'http_client_youtube_wbs_mock.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  test('fetching wbs channel info from youtube api', () async {

    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter(client: HttpClientYoutubeWbsMock());
    YoutubeChannelInfo youtubeChannelInfo =
    await youtubeApiAdapter.getChannelInfo(
        channelId: "UCb5TfGtSgvNPVPQawfCFuAw",
        apiKey: InFluxConfig.youtubeApiKey);

    assert(youtubeChannelInfo.urlIdentifier.toLowerCase() == "kanzleiwbs");
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailResolution.LOW));
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailResolution.MEDIUM));
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailResolution.HIGH));
    assert(youtubeChannelInfo.id == "UCb5TfGtSgvNPVPQawfCFuAw");
    assert(youtubeChannelInfo.title == "Kanzlei WBS");
  });

  test('fetching wbs channel data and the last 20 videos', () async {
    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter(client: HttpClientYoutubeWbsMock());
    YoutubeChannelWithVideos youtubeData =
    await youtubeApiAdapter.getYoutubeChannelAndVideos(
        apiKey: InFluxConfig.youtubeApiKey,
        channelId: "UCb5TfGtSgvNPVPQawfCFuAw",
        maxResults: 20);

    assert(youtubeData.channel.id == "UCb5TfGtSgvNPVPQawfCFuAw");
    assert(youtubeData.channel.title == "Kanzlei WBS");
    assert(youtubeData.videos[0].description != null);
    assert(youtubeData.videos[0].thumbnailUrls.containsKey(ThumbnailResolution.HIGH));
    assert(youtubeData.videos.length == 20);
  });

  test('fetching the last 20 video from wbs youtube channel', () async {
    YoutubeApiAdapter youtubeApiAdapter = YoutubeApiAdapter(client: HttpClientYoutubeWbsMock());
    List<YoutubeVideoInfo> videos = await youtubeApiAdapter.getVideos(
        apiKey: InFluxConfig.youtubeApiKey,
        channelId: InFluxConfig.youtubeChannelId,
        maxResults: 20);

    assert(videos.length == 20);
    assert(videos[0].id != null);
    assert(videos[0].thumbnailUrls.containsKey(ThumbnailResolution.LOW));
    assert(videos[0].publishedAt != null);
    assert(videos[0].description != null);
  });
}
