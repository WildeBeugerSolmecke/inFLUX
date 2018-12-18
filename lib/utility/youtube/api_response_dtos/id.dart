import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'id.g.dart';

abstract class Id implements Built<Id, IdBuilder>{

  static Serializer<Id> get serializer => _$idSerializer;

  String get kind;
  String get videoId;

  Id._();
  factory Id([updates(IdBuilder b)]) =_$Id;

}