import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/twitter/api_resources/size.dart';

part 'sizes.g.dart';

abstract class Sizes implements Built<Sizes, SizesBuilder>{
  static Serializer<Sizes> get serializer => _$sizesSerializer;

  Size get thumb;
  Size get large;
  Size get medium;
  Size get small;

  Sizes._();
  factory Sizes([updates(SizesBuilder b)]) = _$Sizes;
}