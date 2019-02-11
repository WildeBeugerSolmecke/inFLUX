import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'size.g.dart';

abstract class Size implements Built<Size, SizeBuilder>{

  static Serializer<Size> get serializer => _$sizeSerializer;

  @BuiltValueField(wireName: "w")
  int get width;
  @BuiltValueField(wireName: "h")
  int get height;
  String get resize;

  Size._();
  factory Size([updates(SizeBuilder b)]) = _$Size;
}