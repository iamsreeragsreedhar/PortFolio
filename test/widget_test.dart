import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/core/constants.dart';
import 'package:portfoloio_1/main.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final Uint8List encoded = utf8.encoder.convert('{}');
      return encoded.buffer.asByteData();
    });
  });

  testWidgets('Portfolio app smoke and render test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build the portfolio application
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Developer Name appears
    expect(find.text(AppData.name), findsWidgets);

    // Verify Navigation bar & section items
    expect(find.text('Home'), findsWidgets);
    expect(find.text('About'), findsWidgets);
    expect(find.text('Skills'), findsWidgets);
    expect(find.text('Projects'), findsWidgets);
    expect(find.text('Experience'), findsWidgets);
    expect(find.text('Contact'), findsWidgets);
    expect(find.text('Resume'), findsWidgets);

    // Verify Action Buttons
    expect(find.text('Download CV'), findsWidgets);
    expect(find.text('Get In Touch'), findsWidgets);
  });
}
