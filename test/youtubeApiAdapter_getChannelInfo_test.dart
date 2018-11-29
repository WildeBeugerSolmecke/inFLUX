import 'package:flutter_test/flutter_test.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_channel_info.dart';
import '../lib/utility/Youtube/youtube_api_adapter.dart';

void main() {
  test('fetching wbs channel info from "kanzleiwbs"', () async {
    YoutubeApiAdapter youtubeApiAdapter = new YoutubeApiAdapter();
    YoutubeChannelInfo youtubeChannelInfo = await youtubeApiAdapter.getChannelInfo(userName: InFluxConfig.youtubeChannelName, apiKey: InFluxConfig.youtubeApiKey);
    assert(youtubeChannelInfo.title == "Kanzlei WBS");
    assert(youtubeChannelInfo.description.contains("Rechtsprechung "));
    assert(youtubeChannelInfo.thumbnailUrls.containsKey(ThumbnailSize.SMALL));
    assert(youtubeChannelInfo.id == InFluxConfig.youtubeChannelId);
  });
}
