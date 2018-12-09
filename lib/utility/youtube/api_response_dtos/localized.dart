import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'localized.g.dart';

abstract class Localized implements Built<Localized, LocalizedBuilder>{

  static Serializer<Localized> get serializer => _$localizedSerializer;

  String get title;
  String get description;

  Localized._();
  factory Localized([updates(LocalizedBuilder b)]) = _$Localized;
}