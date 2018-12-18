import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'high.g.dart';

abstract class High implements Built<High, HighBuilder>{
  static Serializer<High> get serializer => _$highSerializer;

  String get url;
  int get width;
  int get height;

  High._();
  factory High([updates(HighBuilder b)]) =_$High;
}