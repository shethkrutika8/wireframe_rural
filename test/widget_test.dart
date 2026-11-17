import 'package:flutter_test/flutter_test.dart';
import 'package:wireframe_rural/main.dart';

void main() {
  testWidgets('AgriConnect App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const AgriConnectApp());
    expect(find.text('AgriConnect'), findsWidgets);
  });
}
