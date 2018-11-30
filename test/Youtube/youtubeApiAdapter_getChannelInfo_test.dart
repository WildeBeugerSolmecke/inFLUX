import 'package:flutter_test/flutter_test.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_api_adapter.dart';
import 'package:influx/utility/Youtube/youtube_channel_info.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'http_client_youtube_wbs_mock.dart';

class MockHttpClient extends Mock implements Client{}

void main() {
  test('fetching wbs channel info from youtube api', () async {

    // mock youtube api
    Client httpClient = HttpClientYoutubeWbsMock();

    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter();
    YoutubeChannelInfo youtubeChannelInfo = await youtubeApiAdapter.getChannelInfo(httpClient: httpClient, channelId: "UCb5TfGtSgvNPVPQawfCFuAw", apiKey: InFluxConfig.youtubeApiKey);

    assert(youtubeChannelInfo.urlIdentifier.toLowerCase() == "kanzleiwbs");
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailSize.SMALL));
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailSize.MEDIUM));
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailSize.LARGE));
    assert(youtubeChannelInfo.id == "UCb5TfGtSgvNPVPQawfCFuAw");
    assert(youtubeChannelInfo.title == "Kanzlei WBS");
  });
}
