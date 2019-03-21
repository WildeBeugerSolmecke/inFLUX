import 'package:flutter_test/flutter_test.dart';
import 'package:influx/utility/text_utils.dart';
import 'package:flutter/material.dart';

void main() {
  test("get rich text with clickable urls", () {
    String text = 'This \nte\nxt \u{1f603}	has a https://google.com lin-k and another link https://test.com';
    var urls = <UrlInText>[UrlInText(19, 36), UrlInText(60, 75)];
    var richText = TextUtils.buildRichTextWithClickableUrls(text, urls);
    expect(richText, isNot(null));
  });

  testWidgets('my first widget test', (WidgetTester tester) async {
    String text = 'This \nte\nxt \u{1f603}	has a https://google.com link and another link https://test.com';
    var urls = <UrlInText>[UrlInText(19, 36), UrlInText(60, 75)];
    // Tells the tester to build a UI based on the widget tree passed to it
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Center(
              child:
              TextUtils.buildRichTextWithClickableUrls(text, urls)
          ),
        ),
      ),
    );
  });

  test('testing substring with emoji', (){
    var testString = "emoji\u{1f603} test";
    testString.runes.forEach((rune) => print("rune: $rune"));
    var runes = testString.runes.toList();
    expect(runes.length, 11);
    var substring = String.fromCharCodes(runes.sublist(7));
    expect(substring, "test");
  });

  test('testing substring', (){
    var testString = "Das dürfte die Party 🥳 🎈 🎊🎉 meines Lebens gewesen sein. 26.000 Menschen waren live dabei, als wir nach 8 Jahren YouTube die 300.000 Abo-Marke überschritten haben. P.S.: bei Minute 12:10 h fliegt der Korken.... https://t.co/xoor5JLR4r";
    var sub = testString.substring(210);
    expect(sub, "https://t.co/xoor5JLR4r");
  });

  test('test default int',(){
    int i;
    expect(i, null);
  });
}
