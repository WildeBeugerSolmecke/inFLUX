import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/youtube/api_response_dtos/default.dart';
import 'package:influx/utility/youtube/api_response_dtos/high.dart';
import 'package:influx/utility/youtube/api_response_dtos/medium.dart';

part 'thumbnails.g.dart';

abstract class Thumbnails implements Built<Thumbnails, ThumbnailsBuilder> {

  static Serializer<Thumbnails> get serializer => _$thumbnailsSerializer;

  @BuiltValueField(wireName: 'default')
  Default get low;
  Medium get medium;
  High get high;

  Thumbnails._();
  factory Thumbnails([updates(ThumbnailsBuilder b)]) = _$Thumbnails;

}