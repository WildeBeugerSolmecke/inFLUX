import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'default.g.dart';

abstract class Default implements Built<Default, DefaultBuilder>{

  static Serializer<Default> get serializer => _$defaultSerializer;

  String get url;
  int get width;
  int get height;

  Default._();
  factory Default([updates(DefaultBuilder b)]) =_$Default;

}