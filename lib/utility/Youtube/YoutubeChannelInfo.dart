class YoutubeChannelInfo{
  String title;
  String id;
  String description;
  Map<Size, String> thumbnails;
}

enum Size{
  /// 88x88 pixels
  SMALL,
  /// 240x240 pixels
  MEDIUM,
  /// 800x800 pixels
  LARGE
}

