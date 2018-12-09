import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'medium.g.dart';

abstract class Medium implements Built<Medium, MediumBuilder>{

  static Serializer<Medium> get serializer => _$mediumSerializer;

  String get url;
  int get width;
  int get height;

  Medium._();
  factory Medium([updates(MediumBuilder b)]) =_$Medium;
}