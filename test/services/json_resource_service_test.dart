import 'package:flutter_test/flutter_test.dart';
import 'package:filter/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('JsonResourceServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
